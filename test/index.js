function check(o, type) {
    console.log('in check');
    var cId = o.id.replace('{', '').replace('}', '');
    if (lastId && cId != lastId) {
        document.getElementById(cId).checked = false;
        alert('当前模式下只能选择一个人');
        return;
    }
    else if (lastId && cId == lastId) {
        lastId = null;
    } else {
        lastId = cId;
    }
    if (lastSelectedObj) {
        lastSelectedObj.className = '';
    }
    if ('${userids}'.indexOf(o.id) == -1) {
        return;
    }
    if (type == 1) {
        if ($(o).prev('input').attr('checked')) {
            $(o).prev('input').removeAttr('checked');
        } else {
            $(o).prev('input').attr('checked', 'true')
        }
        if (bmid == o.id) {
            id = o.id.replace('{', '').replace('}', '');
            document.getElementById(id).checked = false;
            bmid = "";
        } else {
            bmid = o.id;
            if (document.getElementById(id)) {
                document.getElementById(id).checked = false;
            }
            id = o.id.replace('{', '').replace('}', '');
            document.getElementById(id).checked = !document.getElementById(id).checked;
        }
    } else {
        if ('${isExchange}' == 1) {
            if (document.getElementById(id)) {
                document.getElementById(id).checked = false;
            }
            if (bmid != o.id) {
                o.className = "checked";
                lastSelectedObj = o;
                bmid = o.id;
            } else {
                bmid = "";
                lastSelectedObj = null;
            }
        }
    }
}

function djcheckbox(ids) {
    console.log('in djcheckbox');
    var cId = ids.replace('{', '').replace('}', '');
    if (lastId && lastId != cId) {
        var item = document.getElementById(cId);
        item.checked = false;
        $('input', item).attr("checked", false);
        alert('当前模式下只能选择一个人');
        return;
    } else if (lastId && lastId == cId) {

        lastId = null;
    } else {
        lastId = cId;
    }
    if (lastSelectedObj) {
        lastSelectedObj.className = '';
    }
    if (bmid == ids) {
        id = ids.replace('{', '').replace('}', '');
        document.getElementById(id).checked = false;
        bmid = "";
    } else {
        bmid = ids;
        if (document.getElementById(id) && ("{" + id + "}") != bmid) {
            document.getElementById(id).checked = false;
        }
        id = ids.replace('{', '').replace('}', '');
    }
}