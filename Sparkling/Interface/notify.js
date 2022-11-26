window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.brow) {
        console.log(item.brow)
        const element = $(`
        <div class="notification">
            <p class="text">${item.brow}</p>
        </div>`).appendTo('.notify')

        element.hide()
        element.fadeIn('slow')

        element.css({
            'border': '3px solid ' +item.color
        })

        setTimeout(() => element.fadeOut('slow', () => element.remove()), 3000)
    }
});