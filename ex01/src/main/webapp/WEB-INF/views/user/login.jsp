<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>

<form action="/user/loginPost" method="post">
	<div class="form-group has-feedback">
		<input type="text" name="uid" class="form-control" placeholder="USER ID"/>
		<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
	</div>
	<div class="form-group has-feedback">
		<input type="password" name="upw" class="form-control" placeholder="Password"/>
		<span class="glyphicon glyphicon-lock form-control-feedback"></span>
	</div>
	<div class="row">
	<div class="col-xs-1"></div>
		<div class="col-xs-7">
			<div class="checkbox icheck">
				<label>
					<input type="checkbox" name="useCookie"> Remember Me
				</label>
			</div>
		</div><!-- /.col -->
		<div class="col-xs-4">
			<button type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
		</div><!-- /.col -->
	</div>
</form>



<%@ include file="../include/footer.jsp"%>