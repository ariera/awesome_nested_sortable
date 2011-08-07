jQuery ->
    $('#sortable ul:first-child').nestedSortable({
            listType: 'ul',
            items: 'li',
            handle: 'p'
    })


    $("#sortable form").submit ->
        serialization = $("#sortable ul:first-child").nestedSortable('serialize')
        input = $("<input>").attr("type", "hidden").attr("name", "order").val(serialization)
        $(this).append($ input)