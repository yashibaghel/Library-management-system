<%@include file="connectionAdmin.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Admin Dashboard</title>

	<!-- Global stylesheets -->
	<link href="https://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700,900" rel="stylesheet" type="text/css">
	<link href="global_assets\css\icons\icomoon\styles.min.css" rel="stylesheet" type="text/css">
	<link href="assets\css\bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="assets\css\bootstrap_limitless.min.css" rel="stylesheet" type="text/css">
	<link href="assets\css\layout.min.css" rel="stylesheet" type="text/css">
	<link href="assets\css\components.min.css" rel="stylesheet" type="text/css">
	<link href="assets\css\colors.min.css" rel="stylesheet" type="text/css">
	<!-- /global stylesheets -->

	<!-- Core JS files -->
	<script src="global_assets\js\main\jquery.min.js"></script>
	<script src="global_assets\js\main\bootstrap.bundle.min.js"></script>
	<script src="global_assets\js\plugins\loaders\blockui.min.js"></script>
	<script src="global_assets\js\plugins\ui\ripple.min.js"></script>
	<!-- /core JS files -->
        
        <!--    sweet alert 2-->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.4/dist/sweetalert2.all.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.4/dist/sweetalert2.min.css" rel="stylesheet">
        

	<!-- Theme JS files -->
	<script src="global_assets\js\plugins\visualization\d3\d3.min.js"></script>
	<script src="global_assets\js\plugins\visualization\d3\d3_tooltip.js"></script>
	<script src="global_assets\js\plugins\forms\styling\switchery.min.js"></script>
	<script src="global_assets\js\plugins\forms\selects\bootstrap_multiselect.js"></script>
	<script src="global_assets\js\plugins\ui\moment\moment.min.js"></script>
	<script src="global_assets\js\plugins\pickers\daterangepicker.js"></script>

	<script src="assets\js\app.js"></script>
	<script src="global_assets\js\demo_pages\dashboard.js"></script>
	<!-- /theme JS files -->
	<style>
            @import url('https://fonts.googleapis.com/css2?family=Catamaran:wght@700&display=swap');
            *{
                font-family: 'Catamaran', sans-serif;
            }
        </style>
</head>

<body>
    
    <input type="hidden" id="status" value="<%= request.getAttribute("status") %>">
    
	<!-- Main navbar -->
        <%@include file="headerAdmin.jsp" %>
	<!-- /main navbar -->

					
	<!-- Page content -->
	<div class="page-content">
            
            <%@include file="adminSideBar.jsp" %>
            
		<!-- Main content -->
		<div class="content-wrapper">

                    <!-- Page header -->
                    <div class="page-header">
                        <div class="page-header-content header-elements-md-inline">
                            <div class="page-title d-flex">
                                <h4>User Record</h4>
                                <a href="#" class="header-elements-toggle text-default d-md-none"><i class="icon-more"></i></a>
                            </div>
                        </div>
                    </div>
                    <!-- /page header -->


                    <!-- Content area -->
			<div class="content pt-0">

				<!-- Dashboard content -->
				<div class="card">
                                    
                                    <div class="card-header header-element-inline">
                                        <h3>User's Record</h3>
                                    </div>
                                    <div class="card-body py-0 mb-4">
                                        
                                        <div class="container">
                                        
                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <th>Id</th>
                                                        <th>Name</th>
                                                        <th>Email</th>
                                                        <th>Roll No</th>
                                                        <th>Type</th>
                                                        <th>Delete</th>
                                                    </tr>                                                    
                                                </thead>
                                                <tbody>
                                                    <%
                                                        try{ 
                                                            connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
                                                            statement=connection.createStatement();
                                                            String sql ="SELECT  id,username,email,rollno,user_type FROM users";
                                                            resultSet = statement.executeQuery(sql);
                                                            int i=1;
                                                            while(resultSet.next()){
                                                                
                                                    %>
                                                    <tr>
                                                        <td><%= i++ %></td>
                                                        <td><%=resultSet.getString("username") %></td>
                                                        <td><%=resultSet.getString("email") %></td>
                                                        <td><%=resultSet.getString("rollno") %></td>
                                                        <td><%=resultSet.getString("user_type") %></td>
                                                        <td>
                                                            <form action="deleteUser" method="post">
                                                                <input type="hidden" name="delete_id" value="<%=resultSet.getString("id") %>">
                                                                <button type="submit" class="btn btn-danger" value="">Delete</button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                    <% 
                                                        }

                                                        } catch (Exception e) {
                                                            e.printStackTrace();
                                                        }
                                                    %>
                                                </tbody>
                                                
                                            </table>                                                 
                                            
                                        </div>
                                    </div>
				</div>
				<!-- /dashboard content -->

			</div>
			<!-- /content area -->


			<!-- Footer -->
                        <%@include file="footerAdmin.jsp" %>
			<!-- /footer -->

		</div>
		<!-- /main content -->

	</div>
	<!-- /page content -->
        
        <script>
            
            // Example starter JavaScript for disabling form submissions if there are invalid fields
            (function() {
              'use strict';
              window.addEventListener('load', function() {
                // Fetch all the forms we want to apply custom Bootstrap validation styles to
                var forms = document.getElementsByClassName('needs-validation');
                // Loop over them and prevent submission
                var validation = Array.prototype.filter.call(forms, function(form) {
                  form.addEventListener('submit', function(event) {
                    if (form.checkValidity() === false) {
                      event.preventDefault();
                      event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                  }, false);
                });
              }, false);
            })();
            
            //alert js
            var status = document.getElementById("status").value;

                if(status == "success"){
                    Swal.fire({
                        icon: 'success',
//                        title: 'Congrats!',
                        text: 'User deleted Successfully'
                      });
                }
                else if(status == "failed"){
                    Swal.fire({
                        icon: 'error',
                        title: 'Something went wrong'
                    });
                }
        </script>
</body>
</html>