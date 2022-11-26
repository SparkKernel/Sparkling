window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.text) {
        const element = $(`<div class="notification">
        
            <div class="color"></div>
            <div class="holder">
                <div class="text">${item.text}</div>
            </div>
        </div>`).appendTo('.notify')

        element.find('.color').css({
            'background-color': item.color
        })

        setTimeout(() => element.remove(), 3000)
    }
});