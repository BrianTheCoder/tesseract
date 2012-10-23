# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#= require underscore
#= require jquery.pjax
#= require_tree .

$(document).ready ->
  fileSelect = (files, callback)->
    self = this
    markup = []
    $.each files, (idx, file)->
      $thumb = $(imageTemplate)
      markup.push $thumb
      reader = new FileReader()
      reader.onload = (e)->
        $thumb.find('a.thumbnail img').attr({
          src: e.target.result
          name: file.name
        })
        
      reader.readAsDataURL file
      
      progressHandler = (e)->
        percent = Math.round((e.loaded/e.total) * 100)
        console.log e, percent
        
        $thumb.find('div.progress div.bar').attr('width', "#{percent}%")
        
      uploadSetup = ->
        myXhr = $.ajaxSettings.xhr()
        if myXhr.upload
          myXhr.upload.addEventListener 'progress', progressHandler, false
        
        myXhr

      data = new FormData()
      data.append 'image[file]', file
      
      $.ajax
        url: "/projects/#{$('#project').data('id')}/images.json"
        type: 'POST'
        xhr: uploadSetup
        success: ->
          $.pjax
            url: "/projects/#{$('#project').data('id')}"
            container: '#main'
        data: data
        cache: false
        contentType: false
        processData: false
      
    
    $('ul.thumbnails').append markup
      
  imageTemplate = "<li class=\"span3\">
    <a href=\"#\" class=\"thumbnail\"><img src=\"http://placehold.it/276x165\" /></a>
    <div class=\"loading\">
      <h4>Uploading</h4>
      <div class=\"progress progress-striped active\">
        <div class=\"bar\"></div>
      </div>
    </div>
  </li>"
  
  $('ul.nav a').on 'click', (e)->
    e.preventDefault()
    $.pjax
      url: $(this).attr('href')
      container: '#main'
  
  $('#main')
    .on 'ajax:success', '#project-form form', (e, data, status, xhr)->
      $('#project-form').modal('hide').find('input:text').val('')
      $.pjax
        url: '/projects'
        container: '#main'
    
    .on 'ajax:success', '#projects ul a.close', (e, data, status, xhr)->
      $(this).closest('li').slideUp ->
        $.pjax
          url: '/projects'
          container: '#main'
    
    .on 'click', '#projects ul a.title', (e)->
      e.preventDefault()
      $.pjax
        url: $(this).attr('href')
        container: '#main'
    
    .on 'ajax:success', '#project ul a.close', (e)->
      $(this).closest('li').slideUp ->
        $.pjax
          url: "/projects/#{$('#project').data('id')}"
          container: '#main'
          
    .on 'click', '#project a.thumbnail', (e)->
      e.preventDefault()
      $.pjax
        url: $(this).attr('href')
        container: '#main'
        
    .on 'ajax:success', '#image a.remove', (e)->
      $('#image').fadeOut ->
        $.pjax
          url: "/projects/#{$('#image').data('project-id')}"
          container: '#main'
    
    .on 'click', '#image a.new-region', (e)->
      e.preventDefault()
      $('#new_region').slideDown()
      updateCoords = (coords)->
        $('#region_x').val coords.x
        $('#region_y').val coords.y
        $('#region_width').val coords.w
        $('#region_height').val coords.h
        
      if $('#image').data('crop')
        $('#image').data('crop').enable(x)
      else
        $('#image div.view').Jcrop
          onChange: updateCoords
          onSelect: updateCoords
        , -> $('#image').data('crop', this)
    
    .on 'click', '#new_region a.cancel', (e)->
      e.preventDefault()
      $('#new_region').slideUp ->
        $(this).find('input:text').val('')
      
      if crop = $('#image').data('crop')
        crop.release()
        crop.disable()
        
    .on 'click', '#new_region a.add', (e)->
      e.preventDefault()
      $('#new_region').submit()
      
    .on 'ajax:success', '#new_region', (e, data, status, xhr)->
      console.log 'boom!', arguments
      
    .on 'mouseover', 'ul.regions li', (e)->
      $self = $(this)
      position = [$self.data('x'), $self.data('y'), $self.data('x') + $self.data('width'), $self.data('y') + $self.data('height')]
      clearTimeout $self.data('timeout')
      
      if crop = $('#image').data('crop')
        crop.setSelect(position)
        crop.disable()
      else
        $('#image div.view').Jcrop
          setSelect: position
        , -> 
          $('#image').data('crop', this)
          this.disable()
    
    .on 'mouseout', 'ul.regions li', (e)->
      timeout = setTimeout ->
        if crop = $('#image').data('crop')
          crop.release()
          crop.disable()
      , 500
      
      $(this).data 'timeout', timeout
      
    .on 'ajax:success', 'ul.regions a.close', (e, data, status, xhr)->
      $(this).closest('li').slideUp ->
        $image = $('#image')
        if crop = $image.data('crop')
          crop.release()
          crop.disable()
        
        $.pjax
          url: "/projects/#{$image.data('project-id')}/images/#{$image.data('id')}"
          container: '#main'
      
    .on 'dragover', '#project', (e)-> 
      e.preventDefault()
      
    .on 'drop', '#project', (e)->
      e.preventDefault()
      transfer = e.dataTransfer || e.originalEvent.dataTransfer
      fileSelect transfer.files
      
    .on 'submit', '#new_image', (e)->
      e.preventDefault()
      $(this).closest('div.modal').modal 'hide'
      fileSelect $(this).find('input:file')[0].files 
      