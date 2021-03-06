<%@page import="java.util.List"%>
<%@page import="ece356.model.ProjectDBAO"%>
<%@page import="ece356.model.Doctor"%>
<%@page import="ece356.model.Gender"%>
<%@page import="ece356.model.Address"%>
<%
    
  Object x = session.getAttribute("user");
  if( x == null || 
      session.getAttribute("userIsDoctor") == null || 
      !(Boolean)session.getAttribute("userIsDoctor")) {
      response.sendRedirect("index.jsp");
      return;
  }
  Doctor d = (Doctor)x;
  if(d == null) {
      response.sendRedirect("index.jsp");
      return;
  }
  List<Address> workAddressArray = ProjectDBAO.getWorkAddressByDoctorID(d.getDoctorID());
  
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="/ece356Project/static/css/bootstrap.min.css" />
        <title>Doctor Home</title>
    </head>
    <body>
        <nav class="navbar navbar-default" role="navigation">
          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
            <a class="navbar-brand" href="#">ECE356 Project</a>
          </div>
        </nav>
        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <h3 style="text-align:center;">Change Doctor Account</h3>
                <br></br>
                <form class="form-horizontal" action="addworkaddress.jsp" method="POST" role="form">                  
                  <div class="form-group">
                    <label for="firstName" class="col-sm-2 control-label">First Name</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="firstName" 
                            id="firstName" placeholder="Enter your first name" value=<%= d.getFirstName() %> disabled>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="lastName" class="col-sm-2 control-label">Last Name</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="lastName" 
                             id="lastName" placeholder="Enter your last name" value=<%= d.getLastName() %> disabled>
                    </div>
                  </div>                            
                  <div class="form-group">
                    <label for="Specialization" class="col-sm-2 control-label">Date of Birth</label>
                    <div class="col-sm-10">
                      <div class="row">

                        <div class="col-xs-3">
                          <select name="dobDay" class="form-control" disabled>
                            <option value="-1">Day</option>
                            <% for (int i = 1; i <= 31; i++) { %>
                               <option value="<%= i %>"
                                       <% if(i == d.getDOB().getDate()) { %> selected="selected" <% } %>
                                       ><%= i %></option>
                            <% } %> 
                          </select>                           
                        </div>

                        <div class="col-xs-3">
                          <select name="dobMonth" class="form-control" disabled>
                            <option value="-1">Month</option>
                            <% String[] months = new String[] {
                                  "January", "February", "March", "April", "May",
                                  "June", "July", "August", "September", "October", "November",
                                  "December"
                            };
                            for (int i = 0; i < months.length; i++) { %>
                               <option value="<%= i %>"
                                       <% if(i == d.getDOB().getMonth()) { %> selected="selected" <% } %>
                                       ><%= months[i] %></option>
                            <% } %>                            
                          </select>                           
                        </div>                        

                        <div class="col-xs-3">
                          <select name="dobYear" class="form-control" disabled>
                            <option value="-1">Year</option>
                            <% for (int i = 2010; i >= 1940; i--) { %>
                               <option value="<%= i %>"
                                       <% if(i == d.getDOB().getYear()) { %> selected="selected" <% } %>
                                       ><%= i %></option>
                            <% } %> 
                          </select>                            
                        </div>                        
                      </div>                                                               
                    </div>
                  </div>                   
                  <div class="form-group">
                    <label for="gender" class="col-sm-2 control-label">Gender</label>
                    <div class="col-sm-10">
                      <label class="radio-inline">
                          <input type="radio" name="gender" id="gender" value="0" <% if(d.getGender() == Gender.Male) { %> checked="checked" <% } %> disabled> Male
                      </label>
                      <label class="radio-inline">
                        <input type="radio" name="gender" id="gender" value="1"  <% if(d.getGender() == Gender.Female) { %> checked="checked" <% } %> disabled> Female
                      </label>                      
                    </div>
                  </div>
                 
                  <div class="form-group">
                    <label for="Specialization" class="col-sm-2 control-label">Year of License</label>
                    <div class="col-sm-10">
                      <div class="row">
                        <div class="col-xs-3">                      
                          <select name="licenseYear" class="form-control" disabled>
                            <% for (int i = 2013; i >= 1950; i--) { %>
                              <option value="<%= i %>"
                                      <% if(i == d.getLicenseYear()) { %> selected="selected" <% } %>
                                      ><%= i %></option>
                            <% } %> 
                          </select>     
                        </div>          
                      </div>               
                    </div>
                  </div>                                      
                  </br> 
                  <h4>Work Addresses</h4>
                  <% for(Address wa : workAddressArray) {%>                  
                  <br>
                  <div class="form-group">
                    <label for="workStreetAddress" class="col-sm-2 control-label">Street Address</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="workStreetAddress" 
                            id="workStreetAddress" placeholder="Enter your street address" value=<%= "\"" + wa.getStreetName() + "\""%> disabled>
                    </div>
                  </div>               
                  <div class="form-group">
                    <label for="workCity" class="col-sm-2 control-label">City</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="workCity" 
                            id="workCity" placeholder="Enter your city" value=<%= "\"" + wa.getCity() + "\""%> disabled>
                    </div>
                  </div>   
                  <div class="form-group">
                    <label for="workPostalCode" class="col-sm-2 control-label">Postal Code</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="workPostalCode" 
                            id="workPostalCode" placeholder="Enter your postal code" value=<%= "\"" + wa.getPostalCode() + "\""%> disabled>
                    </div>                                       
                  </div>   
                  <div class="form-group">
                    <label for="workProvince" class="col-sm-2 control-label">Province</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="workProvince" 
                            id="workProvince" placeholder="Enter your province" value=<%= "\"" + wa.getProvince() + "\""%> disabled>
                    </div>                                
                  </div>  
                    
                    <% if(workAddressArray.size() > 0) {%> 
                  <hr>  
                  <%} }%>
                  <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                      <button type="submit" class="btn btn-lg btn-default">Add Work Address</button>
                    </div>
                  </div>
                    
                  </br>
                  <h4>Home Address</h4>
                  <div class="form-group">
                    <label for="homeStreetAddress" class="col-sm-2 control-label">Street Address</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="homeStreetAddress" 
                            id="homeStreetAddress" placeholder="Enter your street address" value=<%= "\"" + d.getHomeAddress().getStreetName() + "\""%> disabled>
                    </div>
                  </div>               
                  <div class="form-group">
                    <label for="homeCity" class="col-sm-2 control-label">City</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="homeCity" 
                            id="homeCity" placeholder="Enter your city" value=<%= d.getHomeAddress().getCity()%> disabled>
                    </div>
                  </div>   
                  <div class="form-group">
                    <label for="homePostalCode" class="col-sm-2 control-label">Postal Code</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="homePostalCode"
                            id="homePostalCode" placeholder="Enter your postal code" value=<%= d.getHomeAddress().getPostalCode()%> disabled>
                    </div>                                       
                  </div>   
                  <div class="form-group">
                    <label for="homeProvince" class="col-sm-2 control-label">Province</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="homeProvince"
                            id="homeProvince" placeholder="Enter your province code" value=<%= d.getHomeAddress().getProvince()%> disabled>
                    </div>                                
                  </div>                                                                                                
<!--                  <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                      <button type="submit" class="btn btn-lg btn-default">Save Changes</button>
                    </div>
                  </div>                 -->
                </form>           
            </div>  
        </div>
        <script src="/ece356Project/static/js/jquery-1.10.2.min.js"></script> 
        <script src="static/js/bootstrap.min.js"></script>            
    </body>
</html>