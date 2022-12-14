onMessage.push((item) => {
    if (item.brow) {
        const element = $(`
        <div class="notification">
            <p class="text">${item.brow}</p>
        </div>`).appendTo('.notify')

        element.hide()
        element.fadeIn('slow')

        element.css({'border': '3px solid ' +item.color}) // change color

        setTimeout(() => element.fadeOut('slow', () => element.remove()), 3000)
    }
});