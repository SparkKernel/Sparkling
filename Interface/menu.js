window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.index) {
        $('.menu').show()
        item.index -= 1
        const btn = $('.menu .buttons #'+new String(item.index))

        btn.css({"color":'#EF5064'})

        document.getElementById(new String(item.index)).scrollIntoView()

        const next = $('.menu .buttons #'+new String(item.index-1))
        const down = $('.menu .buttons #'+new String(item.index+1))

        const cssData = {'color': '#ffffff'}

        if (item.method == 'up') {
            next.css(cssData)
        } else if (item.method == 'down') {
            down.css(cssData)
        } else if (item.method == 'teleport') {
            $('.menu .buttons #'+new String(item.oldIndex-1)).css(cssData)
        }
    }
});