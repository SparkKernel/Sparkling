onReady.push(() => {
    $('.cancel').click(() => callback('cancel', {}).then(() => $('.prompt').hide()))
    $('.submit').click(() => {callback('submit', {text: $('.input').val()}).then(() => {$('.input').val(''); $('.prompt').hide()})})
})

onMessage.push((item) => {
    if (item.show) {
        if (item.object != "menu") {
            $('.'+item.object).show();
            $('.header3').text(item.text)
            $('.input').css({'font-size': item.size})
        } else {
            $('.'+item.object).css({'display': 'flex'})
            $('.header2').text(item.text)
            $('.header2').css({color: item.color})
        }

        if (item.list) {
            $('.buttons').empty()
            var currentIndex = item.list.length
            
            item.list.forEach(element => {currentIndex -= 1; $('<div id="'+new String(currentIndex)+'" class="button">'+element+'</div>').appendTo('.buttons');});
            $('.menu .buttons #'+new String(item.list.length-1)).css({color: item.color})
        }
    } else {
        if (item.object != "menu") $('.'+item.object).show();
        else $('.'+item.object).css({'display': 'none'})
    }
})