<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>

<c:url value="/users/records" var="recordsUrl"/>
<c:url value="/users/create" var="addUrl"/>
<c:url value="/users/update" var="editUrl"/>
<c:url value="/users/delete" var="deleteUrl"/>

<html>
<head>
	<link rel='stylesheet' type='text/css' media='screen' href='<c:url value="/resources/css/style.css"/>'/>
	<link rel='stylesheet' type='text/css' media='screen' href='<c:url value="/resources/css/jquery-ui.css"/>'/>
<%--	<script type='text/javascript' src='<c:url value="/resources/js/jquery-1.6.4.min.js"/>'></script>--%>
	<script type='text/javascript' src='<c:url value="/resources/js/custom.js"/>'></script>
    <script type='text/javascript' src='<c:url value="/resources/js/jquery-1.10.2.js"/>'></script> 
    <script type='text/javascript' src='<c:url value="/resources/js/jquery-ui.js"/>'></script>
    
	<title>User Records</title>
	
	<script type='text/javascript'>
	$(function() {
		// init
		urlHolder.records = '${recordsUrl}';
		urlHolder.add = '${addUrl}';
		urlHolder.edit = '${editUrl}';
		urlHolder.del = '${deleteUrl}';
		loadTable();
		
		$('#newBtn').click(function() { 
			toggleForms('new');
			toggleCrudButtons('hide');
		});
		
		$('#newRefresh').click(function() { 
			DrawCaptcha();
		});
		
		$('#newRefres').click(function() { 
			DrawCaptcha();
		});
		
		$('#editBtn').click(function() { 
			if (hasSelected()) {
				toggleForms('edit');
				toggleCrudButtons('hide');
				fillEditForm();
			}
		});
		
		$('#reloadBtn').click(function() { 
			loadTable();
		});

		$('#deleteBtn').click(function() {
			//alert('in deleteBtn');
			if (hasSelected()) { 
				submitDeleteRecord();
			}
		});
		
	      $('#dialogBtn').click(function() {
	    	   $( "#dialog-form" ).dialog( "open" );
	        });
	        
		$('#newForm').submit(function() {
			event.preventDefault();
			submitNewRecord();
		});
		
	 <%--     $('#dialog-form').submit(function() {
	            event.preventDefault();
	            submitNewRecord();
	        });
	     --%> 
		
		$('#editForm').submit(function() {
			event.preventDefault();
			submitUpdateRecord();
		});

		$('#closeNewForm').click(function() { 
			toggleForms('hide'); 
			toggleCrudButtons('show');
		});
		
		$('#closeEditForm').click(function() { 
			toggleForms('hide'); 
			toggleCrudButtons('show');
		});
		
	      $( "#dialog-form" ).dialog({
	            autoOpen: false,
	            height: 500,
	            width: 500,
	            modal: true,
	            buttons: {
	                "Create an account": function() {
	                	submitNewRecordDialog();
	                        $( this ).dialog( "close" );
	                        resetNewFormDialog();
	                },
	              
	               
	                Cancel: function() {
	                    $( this ).dialog( "close" );
	                }
	                
	            }
	        });

	});
	</script>
</head>

<body>
	<h1 id='banner'>Record System</h1>
	<hr/>
	
	<table id='tableUsers'>
		<caption></caption>
		<thead>
			<tr>
				<th></th>
				<th>Phone Number</th>
				<th>First Name</th>
				<th>Last Name</th>
				<th>Role</th>
			</tr>
		</thead>
	</table>
	
	<div id='controlBar'>
		<input type='button' value='New' id='newBtn' />
		<input type='button' value='Delete' id='deleteBtn' />
		<input type='button' value='Edit' id='editBtn' />
		<input type='button' value='Reload' id='reloadBtn' />
		<input type='button' value='OpenDialog' id='dialogBtn' />
	</div>
	
	<div id='newForm'>
		<form>
  			<fieldset>
				<legend>Create New Record</legend>
				<label for='newPhoneNumber'>Phone</label><input type='text' id='newPhoneNumber'/><br/>
				
				<label for='newFirstName'>First Name</label><input type='text' id='newFirstName'/><br/>
				<label for='newLastName'>Last Name</label><input type='text' id='newLastName'/><br/>
				<label for='newPassword'>Password</label><input type='password' id='newPassword'/><br/>
				<label for='newRole'>Role</label>
					<select id='newRole'>
						<option value='1'>Admin</option>
						<option value='2' selected='selected'>Regular</option>
					</select><br/>
					
					<label for='newVerify'>Verify Yourself</label><input type='text' id='newVerify'/><br/>
					<input type='button' value='Refresh' id='newRefresh' onclick="DrawCaptcha();"  />
					 <input id="txtCaptcha" type="text" readonly="" style="width:100px"/>
  			</fieldset>
			<input type='button' value='Close' id='closeNewForm' />
			<input type='submit' value='Submit'/>
		</form>
	</div>
	
	<div id='dialog-form' title="Create new user Dialog">
        <form>
            <fieldset>
                <label for='newPhoneNumberDialog'>Phone Number</label>
                <input type='text' id='newPhoneNumberDialog'/><br/>
                
               
                
                <label for='newFirstNameDialog'>First Name</label>
                <input type='text' id='newFirstNameDialog'/><br/>
                
                <label for='newLastNameDialog'>Last Name</label>
                <input type='text' id='newLastNameDialog'/><br/>
                
                 <label for='newPasswordDialog'>Password</label>
                <input type='password' id='newPasswordDialog'/><br/>
                
                <label for='newRoleDialog'>Role</label>
                    <select id='newRoleDialog'>
                        <option value='1'>Admin</option>
                        <option value='2' selected='selected'>Regular</option>
                    </select><br/>
                    <label for='newVerify'>Verify Yourself</label><input type='text' id='newVerify'/><br/>
					<input type='button' value='Refresh' id='newRefresh' onclick="DrawCaptcha();"  />
					 <input id="txtCaptcha" type="text" readonly="" />
            </fieldset>
<%--        <input type='button' value='Close' id='closeNewForm' />
            <input type='submit' value='Submit'/>
--%>
                       
        </form>
    </div>
    
	<div id='editForm'>
		<form>
  			<fieldset>
				<legend>Edit Record</legend>
				
						<label for='editPhoneNumber'>Phone</label><input type='text' id='editPhoneNumber'/><br/>
				<label for='editFirstName'>First Name</label><input type='text' id='editFirstName'/><br/>
				<label for='editLastName'>Last Name</label><input type='text' id='editLastName'/><br/>
				<label for='editRole'>Role</label>
					<select id='editRole'>
						<option value='1'>Admin</option>
						<option value='2' selected='selected'>Regular</option>
					</select>
			</fieldset>
			<input type='button' value='Close' id='closeEditForm' />
			<input type='submit' value='Submit'/>
		</form>
	</div>
	
</body>
</html>