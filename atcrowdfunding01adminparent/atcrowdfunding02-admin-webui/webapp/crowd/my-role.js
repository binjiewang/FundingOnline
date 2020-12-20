function showConfirmModal(roleArray) {
    $("#confirmModal").modal("show");
    $("#roleNameDiv").empty();
    window.roleIdArray=[];

    for (var i = 0; i < roleArray.length; i++) {
        var role = roleArray[i];
        var roleName = role.roleName;
        $("#roleNameDiv").append(roleName+"<br/>");
        window.roleIdArray.push(role.roleId);
    }
}

function generatePage() {
    var pageInfo = getPageInfoRemote();
    fillTableBody(pageInfo);
}

//��ȡpageInfo
function getPageInfoRemote() {
    var ajaxResult = $.ajax({
        url: "role/get/page/info.json",
        type: "post",
        data: {
            pageNum: window.pageNum,
            pageSize: window.pageSize,
            keyword: window.keyword
        },
        async: false,
        dataType: "json"
    });
    console.log(ajaxResult);

    var statusCode = ajaxResult.status;
    if (statusCode != 200) {
        layer.msg(statusCode + " " + ajaxResult.statusText)
    }

    var resultEntity = ajaxResult.responseJSON;

    var result = resultEntity.result;

    if (result == "FAILED") {
        layer.msg(resultEntity.message);
        return null;
    }
    var pageInfo = resultEntity.data;
    return pageInfo;
}

//�����
function fillTableBody(pageInfo) {

    // ���tbody�еľɵ�����
    $("#rolePageBody").empty();

    // ���������Ϊ����û���������ʱ����ʾҳ�뵼����
    $("#Pagination").empty();

    //�ж�pageInfo�Ƿ���Ч
    if (pageInfo == null || pageInfo == undefined || pageInfo.list == null || pageInfo.list.length == 0) {
        $("#rolePageBody").append("<tr><td colspan='4'>��Ǹ��û�в�ѯ������Ҫ�����ݣ�</td></tr>")
        return;
    }

    for (var i = 0; i < pageInfo.list.length; i++) {
        var role = pageInfo.list[i];
        var roleId = role.id;
        var roleName = role.name;

        var numberTd = "<td>" + (i + 1) + "</td>";
        var checkboxTd = "<td><input id='" + roleId + "' class='itemBox' type='checkbox'></td>";
        var roleNameTd = "<td>" + roleName + "</td>";

        var checkBtn = "<button type='button' class='btn btn-success btn-xs'><i class=' glyphicon glyphicon-check'></i></button>";

        // ͨ��button��ǩ��id���ԣ����������ʵҲ���ԣ���roleIdֵ���ݵ�button��ť�ĵ�����Ӧ�����У��ڵ�����Ӧ������ʹ��this.id
        var pencilBtn = "<button id='" + roleId + "' type='button' class='btn btn-primary btn-xs pencilBtn'><i class=' glyphicon glyphicon-pencil'></i></button>";

        // ͨ��button��ǩ��id���ԣ����������ʵҲ���ԣ���roleIdֵ���ݵ�button��ť�ĵ�����Ӧ�����У��ڵ�����Ӧ������ʹ��this.id
        var removeBtn = "<button id='" + roleId + "' type='button' class='btn btn-danger btn-xs removeBtn'><i class=' glyphicon glyphicon-remove'></i></button>";

        var buttonTd = "<td>" + checkBtn + " " + pencilBtn + " " + removeBtn + "</td>";

        var tr = "<tr>" + numberTd + checkboxTd + roleNameTd + buttonTd + "</tr>";

        $("#rolePageBody").append(tr);
    }

    generateNavigator(pageInfo);

}

function generateNavigator(pageInfo) {
    // ��ȡ�ܼ�¼��
    var totalRecord = pageInfo.total;

    // �����������
    var properties = {
        "num_edge_entries": 3,
        "num_display_entries": 5,
        "callback": paginationCallBack,
        "items_per_page": pageInfo.pageSize,
        "current_page": pageInfo.pageNum - 1,
        "prev_text": "��һҳ",
        "next_text": "��һҳ"
    }

    // ����pagination()����
    $("#Pagination").pagination(totalRecord, properties);

}

function paginationCallBack(pageIndex, JQuery) {
    // �޸�window�����pageNum����
    window.pageNum = pageIndex + 1;

    // ���÷�ҳ����
    generatePage();

    // ȡ��ҳ�볬���ӵ�Ĭ����Ϊ
    return false;
}