/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ece356.servlet;

import ece356.model.ProjectDBAO;
import ece356.model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author vincent
 */
public class AddWorkAddressServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    final String ADD_WORK_ADDRESS_JSP = "addworkaddress.jsp";
    final String DOCTOR_HOME_JSP = "doctorhome.jsp";
    final String LOGIN_JSP = "index.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            
        } finally {            
        
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        if(session.getAttribute("user") == null) {
            response.sendRedirect(LOGIN_JSP);
            return;
        } 
        
        User u = (User)session.getAttribute("user");
        
        String workCity          = request.getParameter("workCity");
        String workProvince      = request.getParameter("workProvince");                          
        String workPostalCode    = request.getParameter("workPostalCode");
        String workStreetAddress = request.getParameter("workStreetAddress");
        Connection connection = null;
        try {
            boolean hasError = false;
            if (workCity          == null || workCity.isEmpty()) {
                request.setAttribute("errorWithWorkAddress", true);
                hasError = true;
            }
            if (workProvince      == null || workProvince.isEmpty()) {
                request.setAttribute("errorWithWorkAddress", true);
                hasError = true;
            }
            if (workPostalCode    == null || workPostalCode.isEmpty()) {
                request.setAttribute("errorWithWorkAddress", true);
                hasError = true;
            }
            if (workStreetAddress == null || workStreetAddress.isEmpty()) {
                request.setAttribute("errorWithWorkAddress", true);
                hasError = true;
            }
            if (hasError) {
                request.getRequestDispatcher(ADD_WORK_ADDRESS_JSP).forward(request, response);
            } else {
                connection = ProjectDBAO.getConnection();
                connection.setAutoCommit(false);
                connection.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);                  
                int workAddressID = ProjectDBAO.makeAddress(
                                        connection, workStreetAddress, 
                                        workPostalCode, workCity, workProvince
                                    );
                int[] workAddressArray = { workAddressID };
                ProjectDBAO.addWorkAddresses(connection, u.getUserID(), workAddressArray);
                session.setAttribute("user", u);
                session.setAttribute("userIsDoctor", true);
                response.sendRedirect(DOCTOR_HOME_JSP);
            }
        } catch(Exception e) {
            if(connection != null) {
                try { 
                    connection.rollback();
                    connection.close(); 
                } catch(Exception ex) {}                
            }            
            throw new ServletException(e);
        }        
        
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
