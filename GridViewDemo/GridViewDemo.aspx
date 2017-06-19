<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GridViewDemo.aspx.cs" Inherits="GridViewDemo.GridViewDemo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Satyaprakash Samantara.</title>
    <%--Botstraps Part--%> 
    <style>
        .button {
            background-color: #4caf50;
            border: none;
            color: white;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
        }

        .DataGridFixedHeader {
            color: white;
            font-size: 13px;
            font-family: Verdana;
            background-color: yellow;
        }

        .grid_item {
            background-color: #e3eaeb;
            border-width: 1px;
            font-family: Verdana;
            border-style: solid;
            font-size: 12pt;
            color: black;
            background-color: white;
        }

        .grid_alternate {
            border-width: 1px;
            font-family: Verdana;
            border-style: solid;
            font-size: 12pt;
            color: black;
            background-color: white;
        }

        .button4 {
            border-radius: 9px;
        }

        input[type=text], select {

            width: 40%;
            padding: 12px 20px;
            margin: 10px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-family: 'Montserrat', sans-serif;
            text-indent: 10px;
            color: blue;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
            font-size: 20px;
        }

    </style>   
    <%--Botstraps Part--%>   
    
    <%--validation--%>
    <link href="css/template.css" rel="stylesheet" />
    <link href="css/validationEngine.jquery.css" rel="stylesheet" />
    <script src="js/jquery-1.6.min.js"></script>
    <script src="js/jquery.validationEngine-en.js"></script>
    <script src="js/jquery.validationEngine.js"></script>       
    
    <script>
        jQuery(document).ready(function() {
            jQuery('#form1').validationEngine();
        })
    </script> 
    <%--validation--%>
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>  

</head>
<body>
    <form id="form1" runat="server">   
      <fieldset>
            <legend style="font-family: Arial Black; background-color: yellow; color: red; font-size: large;font-style: oblique">Emilio's Real - Time Project</legend>
        
            <table  align="center">
                <tr>
                    <td colspan="3" align="center" class="auto-style1">
                        <strong style="background-color: yellow; color: blue; text-align: center; font-style: oblique">Emilio's Real Time GridView CRUD Using store Procedure In ASP.NET</strong>
                   </td>
                </tr>
                <tr>
                    <td style="text-align: center">
                       <asp:TextBox runat="server" ID="txtFirstName" placeholder="Enter First Name....." ValidationGroup="add" CssClass="validate[required]"></asp:TextBox> 
                    </td>
                </tr> 
                <tr>
                    <td style="text-align: center">
                        <asp:TextBox runat="server" ID="txtLastName" placeholder="Enter Last Name....." ValidationGroup="add" CssClass="validate[required]"></asp:TextBox> 
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center">
                        <asp:TextBox runat="server" ID="txtPhone" placeholder="Enter Phone Number....." ValidationGroup="add" CssClass="validate[required, custom[phone]"></asp:TextBox> 
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center">
                        <asp:TextBox runat="server" ID="txtEmail" placeholder="Enter Email Address....." ValidationGroup="add" CssClass="validate[required, custom[email]"></asp:TextBox> 
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center">
                        <asp:TextBox runat="server" ID="txtSalary" placeholder="Enter Salary....." ValidationGroup="add" CssClass="validate[required, custom[number]"></asp:TextBox> 
                    </td>
                </tr>
               <tr>
                   <td colspan="3" align="center">
                    <asp:Button runat="server" id="btnAddEmployee" Text="Add" OnClick="btnAddEmployee_Click" class="button button4" ValidationGroup="add"/>
                    <asp:Button runat="server" id="btnUpdate" Text="Update" class="button button4" OnClick="btnUpdate_Click"/>
                    <asp:Button runat="server" ID="btnReset" Text="Resst" class="button button4" OnClick="btnReset_Click"/>
                   </td>
               </tr>  
                <tr>
                    <td colspan="3" align="center">
                     <br/>
                        <asp:Label runat="server" ID="lblMensaje"></asp:Label> 
                        <br/>
                        <br/>
                    </td>
                </tr>  
                <tr>  
                    <td colspan="3">  
                        <asp:GridView ID="grvEmployee" runat="server" AllowPaging="true" CellPadding="2" EnableModelValidation="True"  
                                      ForeColor="red" GridLines="Both" ItemStyle-HorizontalAlign="center" EmptyDataText="There Is No Records In Database!" AutoGenerateColumns="false" Width="1100px"  
                                      HeaderStyle-ForeColor="blue"   OnPageIndexChanging="grvEmployee_PageIndexChanging" OnRowCancelingEdit="grvEmployee_RowCancelingEdit" OnRowDeleting="grvEmployee_RowDeleting" OnRowEditing="grvEmployee_RowEditing">  
                            <HeaderStyle CssClass="DataGridFixedHeader" />  
                            <RowStyle CssClass="grid_item" />  
                            <AlternatingRowStyle CssClass="grid_alternate" />  
                            <FooterStyle CssClass="DataGridFixedHeader" />  
                            <Columns>  
                                <asp:TemplateField HeaderText="Id">  
                                    <HeaderStyle HorizontalAlign="Left" />  
                                    <ItemStyle HorizontalAlign="Left" />  
                                    <ItemTemplate>  
                                        <asp:Label runat="server" ID="lblId" Text='<%#Eval("Id") %>'></asp:Label>  
                                    </ItemTemplate>  
                                </asp:TemplateField>  
                                <asp:TemplateField HeaderText="First Name">  
                                    <HeaderStyle HorizontalAlign="Left" />  
                                    <ItemStyle HorizontalAlign="Left" />  
                                    <ItemTemplate>  
                                        <asp:Label runat="server" ID="lblFirstName" Text='<%#Eval("FirstName") %>'></asp:Label>  
                                    </ItemTemplate>  
                                          
                                </asp:TemplateField>  
                                <asp:TemplateField HeaderText="Last Name">  
                                    <HeaderStyle HorizontalAlign="Left" />  
                                    <ItemStyle HorizontalAlign="Left" />  
                                    <ItemTemplate>  
                                        <asp:Label runat="server" ID="lblLastName" Text='<%#Eval("LastName") %>'></asp:Label>  
                                    </ItemTemplate>  
                                          
                                </asp:TemplateField>  
                                <asp:TemplateField HeaderText="Phone Number.">  
                                    <HeaderStyle HorizontalAlign="Left" />  
                                    <ItemStyle HorizontalAlign="Left" />  
                                    <ItemTemplate>  
                                        <asp:Label runat="server" ID="lblPhone" Text='<%#Eval("Phone") %>'></asp:Label>  
                                    </ItemTemplate>  
                                          
                                </asp:TemplateField>  
                                <asp:TemplateField HeaderText="Email">  
                                    <HeaderStyle HorizontalAlign="Left" />  
                                    <ItemStyle HorizontalAlign="Left" />  
                                    <ItemTemplate>  
                                        <asp:Label runat="server" ID="lblEmail" Text='<%#Eval("Email") %>'></asp:Label>  
                                    </ItemTemplate>  
                                          
                                </asp:TemplateField>  
  
                                <asp:TemplateField HeaderText="Salary">  
                                    <HeaderStyle HorizontalAlign="Left" />  
                                    <ItemStyle HorizontalAlign="Left" />  
                                    <ItemTemplate>  
                                        <asp:Label runat="server" ID="lblSalary" Text='<%#Eval("Salary") %>'></asp:Label>  
                                    </ItemTemplate>  
                                        
                                </asp:TemplateField>  
                                <asp:TemplateField HeaderText="Update">  
                                    <HeaderStyle HorizontalAlign="Left" />  
                                    <ItemStyle HorizontalAlign="Left" />  
                                    <ItemTemplate>  
                                        <asp:LinkButton runat="server" ID="btnEdit" Text="Edit" CommandName="Edit" ToolTip="Click here to Edit the record" />                                                                                         
                                    </ItemTemplate>  
                                         
                                </asp:TemplateField>  
                                <asp:TemplateField HeaderText="Delete">  
                                    <HeaderStyle HorizontalAlign="Left" />  
                                    <ItemStyle HorizontalAlign="Left" />  
                                    <ItemTemplate>                                                                          
                                        <asp:LinkButton runat="server" ID="btnDelete" Text="Delete" CommandName="Delete" OnClientClick="return confirm('Are You Sure You want to Delete the Record?');" ToolTip="Click here to Delete the record" />  
                                        </span>  
                                    </ItemTemplate>                                         
                                </asp:TemplateField>  
                            </Columns>  
  
                        </asp:GridView>  
                    </td>  
                </tr>  
            </table>    
        </fieldset>     
    </form>
</body>    
    <br />
    <br />
<footer>    
    <p style="background-color: Yellow; font-weight: bold; color:blue; text-align: center; font-style: oblique">© <script> document.write(new Date().toDateString()); </script></p>    
</footer>   
</html>
