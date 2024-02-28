import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;


@WebServlet("studentRegister.java")
public class studentRegister extends HttpServlet {    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            response.setContentType("text/html;charset=UTF-8");
                Connection con;
                PreparedStatement ps,emailPs;
                Statement st;
                ResultSet rsBook;
                RequestDispatcher dispatcher = null;
                
                
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String dob = request.getParameter("dob");
                String rollno = request.getParameter("rollno");
                String department = request.getParameter("department");
                String userType = request.getParameter("userType");
                
                
//                PrintWriter out = response.getWriter();
//                out.print(bookPic);
//                out.print(uploadPath);
//                out.print(bookName);
//                out.print(bookDetils);
//                out.print(bookAuthor);
//                out.print(bookPub);
//                out.print(branch);
//                out.print(bookPrice);
//                out.print(bookQuantity);
//                out.print(bookAva);
//                out.print(bookRent);

                  
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/LMS","root","root");
            
            emailPs = con.prepareStatement("select email from users where email='"+email+"'");
            
            rsBook = emailPs.executeQuery();
            
            dispatcher = request.getRequestDispatcher("stu_register.jsp");
            
            if(rsBook.next()){
                request.setAttribute("status","exist");
                dispatcher.forward(request, response);
            }
            
            else{
                
                ps = con
                .prepareStatement("insert into users(username,email,password,dob,rollno,department,user_type)values(?,?,?,?,?,?,?)");
            
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, password);
                ps.setString(4, dob);
                ps.setString(5, rollno);
                ps.setString(6, department);
                ps.setString(7, userType);

                int count = ps.executeUpdate();

                dispatcher = request.getRequestDispatcher("stu_register.jsp");

                if(count > 0){
                    request.setAttribute("status","success");
                }
                else{
                    request.setAttribute("status", "failed");
                }
                dispatcher.forward(request, response);
            }
            
            
        }
        catch(Exception e){
            System.out.println("Connection error");
        }
    }
}