//����zTree
function generatorZTree() {
    $.ajax({
        url: "menu/get/whole/tree.json",
        type: "post",
        dataType: "json",
        success: function (response) {
            var result = response.result;
            if (result == "SUCCESS") {
                var setting = {
                    view: {addDiyDom: myAddDiyDom,
                        addHoverDom: myAddHoverDom,
                        removeHoverDom: myRemoveHoverDom},
                    data: {key: {url: "noUrl"}}
                };
                $.fn.zTree.init($("#treeDemo"), setting, response.data);
            }

            if (result == "FAILED") {
                layer.msg("��ʼ��ʧ�ܣ�" + response.message);
            }
        }
    });
}

//�޸�Ĭ��ͼ��
function myAddDiyDom(treeId,treeNode) {
    console.log(treeId);
    console.log(treeNode);

    //�ı�span��class���ɸı�ͼ��
    var spanId = treeNode.tId+"_ico";
    $("#"+spanId).removeClass().addClass(treeNode.icon);
}

function myAddHoverDom(treeId,treeNode){
    var btnGroupId = treeNode.tId+"_btnGrp";
    var anchorId = treeNode.tId+"_a";
    if ($("#"+btnGroupId).length>0){
        return;
    }

    // ׼��������ť��HTML��ǩ
    var addBtn = "<a id='"+treeNode.id+"' class='addBtn btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' href='#' title='����ӽڵ�'>&nbsp;<i class='fa fa-fw fa-plus rbg '></i></a>";
    var removeBtn = "<a id='"+treeNode.id+"' class='removeBtn btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' href='#' title='ɾ���ڵ�'>&nbsp;<i class='fa fa-fw fa-times rbg '></i></a>";
    var editBtn = "<a id='"+treeNode.id+"' class='editBtn btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' href='#' title='�޸Ľڵ�'>&nbsp;<i class='fa fa-fw fa-edit rbg '></i></a>";

    var level = treeNode.level;
    var btnHTML="";

    if(level==0){
        btnHTML=addBtn;
    }

    if(level==1){
        btnHTML=addBtn +" "+editBtn;
        if(treeNode.children.length==0){
            btnHTML = btnHTML +" "+ removeBtn;
        }
    }

    if(level == 2) {
        btnHTML = editBtn + " " + removeBtn;
    }

    $("#"+anchorId).after("<span id='"+btnGroupId+"'>"+btnHTML+"</span>");
}

function myRemoveHoverDom(treeId,treeNode){
    var btnGroupId = treeNode.tId+"_btnGrp";
    $("#"+btnGroupId).remove();
}