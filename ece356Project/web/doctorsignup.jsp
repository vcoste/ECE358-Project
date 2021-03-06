    <%-- 
    Document   : doctorsignup
    Created on : Nov 16, 2013, 5:58:06 PM
    Author     : Sola
--%>
<%@page import="java.util.List"%>
    <%@page import="ece356.model.Specialization"%>
<%@page import="ece356.model.ProjectDBAO"%>
<%@page import="ece356.model.Gender"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="static/css/bootstrap.min.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Doctor Sign up</title>
    </head>
    <body>
        <nav class="navbar navbar-default" role="navigation">
          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
            <a class="navbar-brand" href="#">ECE356 Project</a>
          </div>
        </nav>
        <div class="row">
            <% 
            String firstNameError = "";
            if (request.getAttribute("errorWithFirstName") != null) {
              firstNameError = "has-error";
            }  
            String lastNameError = "";
            if (request.getAttribute("errorWithLastName") != null) {
              lastNameError = "has-error";
            }  
            String aliasError = "";
            if (request.getAttribute("errorWithAlias") != null) {
              aliasError = "has-error";
            } 
            String emailError = "";
            if (request.getAttribute("errorWithEmail") != null) {
              emailError = "has-error";
            }
            String homeAddressError = "";
            if (request.getAttribute("errorWithHomeAddress") != null) {
              homeAddressError = "has-error";
            }
            String workAddressError = "";
            if (request.getAttribute("errorWithWorkAddress") != null) {
              workAddressError = "has-error";
            }
            String passwordError = "";
            if (request.getAttribute("errorWithPassword") != null) {
              passwordError = "has-error";
            }
            String genderError = "";
            if (request.getAttribute("errorWithGender") != null) {
              genderError = "has-error";
            }
            String licenseError = "";
            if (request.getAttribute("errorWithLicense") != null) {
              licenseError = "has-error";
            }
            String specsError = "";
            if (request.getAttribute("errorWithSpecs") != null) {
              specsError = "has-error";
            }
            String dobError = "";
            if (request.getAttribute("errorWithDob") != null) {
              dobError = "has-error";
            }            
            %>
            <div class="col-md-6 col-md-offset-3">
                <h3 style="text-align:center;">Create Doctor Account</h3>
                <br></br>
                <form class="form-horizontal" action="CreateDoctorServlet" method="POST" role="form">
                  <div class="form-group <%= aliasError %>">
                    <label for="alias" class="col-sm-2 control-label">Username</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="alias" 
                            id="alias" placeholder="Enter a username">
                    </div>
                  </div>                  
                  <div class="form-group <%= firstNameError %>">
                    <label for="firstName" class="col-sm-2 control-label">First Name</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="firstName" 
                            id="firstName" placeholder="Enter your first name">
                    </div>
                  </div>
                  <div class="form-group <%= lastNameError %>">
                    <label for="lastName" class="col-sm-2 control-label">Last Name</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="lastName" 
                            id="lastName" placeholder="Enter your last name">
                    </div>
                  </div>
                  <div class="form-group <%= passwordError %>">
                    <label for="password" class="col-sm-2 control-label">Password</label>
                    <div class="col-sm-10">
                      <input type="password" class="form-control" name="password" 
                            id="password" placeholder="Password">
                    </div>
                  </div>         
                  <div class="form-group <%= passwordError %>">
                    <label for="extraPassword" class="col-sm-2 control-label">Re-Enter Password</label>
                    <div class="col-sm-10">
                      <input type="password" class="form-control" name="extraPassword" 
                            id="extraPassword" placeholder="Re-enter Password">
                    </div>
                  </div>                           
                  <div class="form-group <%= dobError %>">
                    <label for="Specialization" class="col-sm-2 control-label">Date of Birth</label>
                    <div class="col-sm-10">
                      <div class="row">

                        <div class="col-xs-3">
                          <select name="dobDay" class="form-control">
                            <option value="-1">Day</option>
                            <% for (int i = 1; i <= 31; i++) { %>
                               <option value="<%= i %>"><%= i %></option>
                            <% } %> 
                          </select>                           
                        </div>

                        <div class="col-xs-3">
                          <select name="dobMonth" class="form-control">
                            <option value="-1">Month</option>
                            <% String[] months = new String[] {
                                  "January", "February", "March", "April", "May",
                                  "June", "July", "August", "September", "October", "November",
                                  "December"
                            };
                            for (int i = 0; i < months.length; i++) { %>
                               <option value="<%= i %>"><%= months[i] %></option>
                            <% } %>                            
                          </select>                           
                        </div>                        

                        <div class="col-xs-3">
                          <select name="dobYear" class="form-control">
                            <option value="-1">Year</option>
                            <% for (int i = 2010; i >= 1940; i--) { %>
                               <option value="<%= i %>"><%= i %></option>
                            <% } %> 
                          </select>                            
                        </div>                        
                      </div>                                                               
                    </div>
                  </div>                   
                  <div class="form-group <%= genderError %>">
                    <label for="gender" class="col-sm-2 control-label">Gender</label>
                    <div class="col-sm-10">
                      <label class="radio-inline">
                          <input type="radio" name="gender" id="gender" value="<%= Gender.Male %>" checked> Male
                      </label>
                      <label class="radio-inline">
                        <input type="radio" name="gender" id="gender" value="<%= Gender.Female %>"> Female
                      </label>                      
                    </div>
                  </div>
                  <div class="form-group <%= specsError %>">
                    <label for="Specialization" class="col-sm-2 control-label">Specialization</label>
                    <div class="col-sm-10">
                      <% int j = 1;
                      for(Specialization spec: ProjectDBAO.getSpecializations()) { %>
                        <label class="checkbox-inline">
                          <input type="checkbox" name="specialization" 
                                id="specialization" value="<%= spec.getSpecID() %>">
                           <%= spec.getName() %>
                        </label>         
                        <% if(j++ % 3 == 0) { %> </br> <% } %>                                         
                      <% } %>                                          
                    </div>
                  </div>
                  <div class="form-group <%= licenseError %>">
                    <label for="Specialization" class="col-sm-2 control-label">Year of License</label>
                    <div class="col-sm-10">
                      <div class="row">
                        <div class="col-xs-3">                      
                          <select name="licenseYear" class="form-control">
                            <% for (int i = 2013; i >= 1950; i--) { %>
                              <option value="<%= i %>"><%= i %></option>
                            <% } %> 
                          </select>     
                        </div>          
                      </div>               
                    </div>
                  </div>                                      
                  </br>                
                  <h4>Work Address</h4>
                  <div class="form-group <%= workAddressError %>">
                    <label for="workStreetAddress" class="col-sm-2 control-label">Street Address</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="workStreetAddress" 
                            id="workStreetAddress" placeholder="Enter your street address">
                    </div>
                  </div>               
                  <div class="form-group <%= workAddressError %>">
                    <label for="workCity" class="col-sm-2 control-label">City</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="workCity" 
                            id="workCity" placeholder="Enter your city">
                    </div>
                  </div>   
                  <div class="form-group <%= workAddressError %>">
                    <label for="workPostalCode" class="col-sm-2 control-label">Postal Code</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="workPostalCode" 
                            id="workPostalCode" placeholder="Enter your postal code">
                    </div>                                       
                  </div>   
                  <div class="form-group <%= workAddressError %>">
                    <label for="workProvince" class="col-sm-2 control-label">Province</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="workProvince" 
                            id="workProvince" placeholder="Enter your province code">
                    </div>                                
                  </div>  
                  </br>
                  <h4>Home Address</h4>
                  <div class="form-group <%= homeAddressError %>">
                    <label for="homeStreetAddress" class="col-sm-2 control-label">Street Address</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="homeStreetAddress" 
                            id="homeStreetAddress" placeholder="Enter your street address">
                    </div>
                  </div>               
                  <div class="form-group <%= homeAddressError %>">
                    <label for="homeCity" class="col-sm-2 control-label">City</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="homeCity" 
                            id="homeCity" placeholder="Enter your city">
                    </div>
                  </div>   
                  <div class="form-group <%= homeAddressError %>">
                    <label for="homePostalCode" class="col-sm-2 control-label">Postal Code</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="homePostalCode"
                            id="homePostalCode" placeholder="Enter your postal code">
                    </div>                                       
                  </div>   
                  <div class="form-group <%= homeAddressError %>">
                    <label for="homeProvince" class="col-sm-2 control-label">Province</label>
                    <div class="col-sm-4">
                      <select class="form-control" name="homeProvince" id="homeProvince">
                          <option value="Ontario">Ontario</option>
                          <option value="Québec">Québec</option>
                          <option value="British Columbia">British Columbia</option>
                          <option value="Alberta">Alberta</option>
                          <option value="Nova Scotia">Nova Scotia</option>
                          <option value="New Brunswick">New Brunswick</option>
                          <option value="Manitoba">Manitoba</option>
                          <option value="Saskatchewan">Saskatchewan</option>
                          <option value="Prince Edward Island">Prince Edward Island</option>
                          <option value="Newfoundland and Labrador">Newfoundland and Labrador</option>
                      </select>  
                    </div>                                                  
                  </div>                                                                                                   
                  <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                      <button type="submit" class="btn btn-lg btn-default">Sign up</button>
                    </div>
                  </div>                 
                </form>           
            </div>  
        </div>
        <script src="/ece356Project/static/js/jquery-1.10.2.min.js"></script> 
        <script src="static/js/bootstrap.min.js"></script>            
    </body>
</html>
