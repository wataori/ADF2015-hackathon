$ ->
    params = {}
    window.location.search.substring(1).split("&").forEach (e) ->
        param = e.split("=")
        params[param[0]] = param[1]

    $canvas = $("#canvas")
    canvas = $canvas.get 0
    ctx = canvas.getContext "2d"
    img = new Image()
    #img.crossOrigin = "Anonymous"
    img.onload = ->
        point = 120
        canvas.width = img.width
        canvas.height = img.height
        ctx.drawImage img, 0, 0
        ctx.fillStyle   = "#ffffff"
        ctx.strokeStyle = "#000000"
        ctx.font = "bold #{point}px Oswald"
        $canvas.on "mousedown", (e) ->
            ctx.fillText("LGTM", e.offsetX, e.offsetY)

        $("#up").on "click", (e) ->
            up canvas.toDataURL()

    img.src = params["u"]

    up = (dataURL) ->
        $.ajax
            url: "up.php"
            type: "POST"
            data: {image: dataURL.replace(/^data:image\/png;base64,/, '')},
            dataType: 'json'

    textImageURL = (height) ->
        canvas = $("<canvas>").get 0
        canvas.width = height * 5
        canvas.height = height
        ctx = canvas.getContext "2d"
        ctx.fillStyle   = "#ffffff"
        ctx.strokeStyle = "#000000"
        ctx.font = "bold #{height}px Oswald"
        ctx.fillText("LGTM", 0, height)
        return canvas.toDataURL("image/png")
