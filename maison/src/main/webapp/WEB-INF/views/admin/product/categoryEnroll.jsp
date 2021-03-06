<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>    
<style>
	.form-control{
		width:90%;
	}
	#Catecontainer{
		padding:10%;
		margin-bottom:15%;
	}
	#btn{
		float:right;
		color:#F2BB9C;
	}
	input{
		font-size:15px;
		line-height:25px;
	}
	select[name='largeCate']{
		font-size:15px;
		margin-right:5%;
	}
	select[name='mediumCate']{
		font-size:15px;
		display: inline-block;
	     vertical-align: top;
	     border: solid #DCDFE3 1px;
	     margin-bottom:5%;
	     width:100px;
	}
	#Catecontainer{
		border:#F2BB9C solid 1px;
	}
	label{
		float:left;
		margin-right:2%;
	}
	i{
		color:red;
	}
</style>
<!-- Start -->
<div class="shop-list-box">
	<div class="container">
<h2>카테고리 추가등록</h2><br>
<div id="Catecontainer">
<form action="${ path }/admin/product/enrollCate.do" name="submitForm" method="post">
<div id="CateArea" class="form-group required">
<label for="category" class="label-title">카테고리 [대]<i>*</i></label>
            <select class="form-group left" id="largeCate" name="largeCate"  style='float:left;'>
            	<option value="">선택하세요</option>
            	<option value="주방">주방</option>	
            	<option value="욕실">욕실</option>
            	<option value="세탁실">세탁실</option>
            	<option value="현관">현관</option>
            	<option value="창고">창고</option>
            </select>
            
<label for="category" class="label-title">카테고리 [중]<i>*</i></label>
<select class="form-group right" id="mediumCate" name="mediumCate" size="5" style='float:right;'>
	<option value="">선택하세요</option>
</select>
</div>
<br><br><br><br>
<label for="mcName" class="label-title">추가할 카테고리<i>*</i></label>
<input type="text"  name="mcName" id="mcName" size="45" required>
<br>
<span style="color:tomato;"></span>
<br><br><br>
<a  class="btn" id="btn">등록</button>
</div>
</form>
</div>
<script>

$(function(){
	selectMediCate();
	
	/* mediumcate값과 input값 비교해서 span띄우기 보류 
	$("#mcName").blur(function(){
		var inputCate = $(this).val();
		var selectCate = $(this).parent().find("select").eq(1).children();
		var mdCate=selectCate.attr('value');
		$(this).parent().find("select").eq(1).children().each(function(){
			if(this.value==inputCate){
				$("span").append("입력하신 카테고리는 이미 존재합니다.");
				
			}
		})
	}); */
			
		
	
	$("#btn").click(function(){
		var insertCate = $('[name=submitForm]').serialize();
		if($("#largeCate").val()==""){
				alert("카테고리[대]를 선택하세요");
				return;
		}else{
			if($("#mcName").val()==""){
				alert("추가할 카테고리를 입력하세요");			
			}
		}
		enrollCate(insertCate);
	});
	
	function selectMediCate(){
		$("#largeCate").change(function(){
			var largeCate = $("#largeCate").val();

			$.ajax({
				url:"${path}/admin/product/selectMedicate.do",
				data:{"large":largeCate},
				type:"post",
				dataType:"json",
				success:function(data){
					console.log("ajax통신성공"+data);
					var mc = $("#mediumCate");
					if(data.length>0){
	    				mc.empty();
	    				for(var i=0;i<data.length;i++){
	    					 var option = $("<option value = '"+data[i].mcName + "'>"+data[i].mcName +"</option>");
	    		               mc.append(option); 
	    				}
	    			}else{
	    				mc.empty();
	    				mc.append("<option value=' '>선택</option>");
	    			}
				},
				error:function(){
					console.log("ajax통신실패");
				}
			})
		})
	}
	function enrollCate(insertCate){
		$.ajax({
			url:"${ path }/admin/product/enrollCate.do",
			type:"post",
			data:insertCate,
			success:function(data){
				if(data==1){
					console.log("ajax통신성공");
					alert("카테고리 추가 등록 성공");
					self.close();
				}else{
					alert("카테고리 추가 등록이 실패하였습니다.")
				}
			},
			error:function(){
				console.log("ajax통신실패");
			}
		})

	};
	
})	

</script>
