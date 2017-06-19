using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GridViewDemo
{
    public partial class GridViewDemo : System.Web.UI.Page
    {
        private string strConnectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        private SqlCommand sqlCommand;
        private SqlDataAdapter sqlDataAdapter;
        private DataSet dataSet;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindEmployeeData();
            }

            btnUpdate.Visible = false;
            btnAddEmployee.Visible = true;
        }

        private void BindEmployeeData()
        {
            try
            {
                CreateConection();
                OpenConection();
                sqlCommand.CommandText = "SP_GridCrud";
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.Parameters.AddWithValue("@Event", "Select");
                sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                dataSet = new DataSet();
                sqlDataAdapter.Fill(dataSet);
                grvEmployee.DataSource = dataSet;
                grvEmployee.DataBind();
            }
            catch (Exception e)
            {
                Response.Redirect("The Error is " + e);
            }
            finally
            {
                CloseConnection();
                DisposeConnection();
            }
        }

        private static void ShowAlertMessage(string error)
        {
            System.Web.UI.Page page = System.Web.HttpContext.Current.Handler as System.Web.UI.Page;
            if (page != null)
            {
                error = error.Replace("'", "\'");
                System.Web.UI.ScriptManager.RegisterStartupScript(page, page.GetType(), "err_msg", "alert('" + error +"');", true);
            }
        }

        private void DisposeConnection()
        {
             sqlCommand.Connection.Dispose();

        }

        private void CloseConnection()
        {
            sqlCommand.Connection.Close();
        }

        private void OpenConection()
        {
            sqlCommand.Connection.Open();
        }

        private void CreateConection()
        {

            SqlConnection sqlConnection = new SqlConnection(strConnectionString);
            sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConnection;
        }

        protected void btnAddEmployee_Click(object sender, EventArgs e)
        {
            try
            {
                CreateConection();
                OpenConection();
                sqlCommand.CommandText = "SP_GridCrud";
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.Parameters.AddWithValue("@Event", "Add");
                sqlCommand.Parameters.AddWithValue("@FirstName", Convert.ToString(txtFirstName.Text));
                sqlCommand.Parameters.AddWithValue("@LastName", Convert.ToString(txtLastName.Text));
                sqlCommand.Parameters.AddWithValue("@Phone", Convert.ToString(txtPhone.Text));
                sqlCommand.Parameters.AddWithValue("@Email", Convert.ToString(txtEmail.Text));
                sqlCommand.Parameters.AddWithValue("@Salary", Convert.ToDecimal(txtSalary.Text));
                int result = Convert.ToInt32(sqlCommand.ExecuteNonQuery());
                if (result > 0)
                {
                    ShowAlertMessage("Record Is inserted seccessfuylly.");
                    BindEmployeeData();
                    ClearControls();
                }
                else
                {
                    ShowAlertMessage("Failed");
                }
            }
            catch (Exception exception)
            {
                ShowAlertMessage("Check your input Data.!" + exception);
            }
            finally
            {
                CloseConnection();
                DisposeConnection();
            }
        }

        private void ClearControls()
        {
            txtFirstName.Text = string.Empty;
            txtLastName.Text  = string.Empty;
            txtPhone.Text     = string.Empty;
            txtEmail.Text     = string.Empty;
            txtSalary.Text    = string.Empty;
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                CreateConection();
                OpenConection();

                sqlCommand.CommandText = "SP_GridCrud";
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.Parameters.AddWithValue("@Event", "Update");
                sqlCommand.Parameters.AddWithValue("@FirstName", Convert.ToString(txtFirstName.Text));
                sqlCommand.Parameters.AddWithValue("@LastName", Convert.ToString(txtLastName.Text));
                sqlCommand.Parameters.AddWithValue("@Phone", Convert.ToString(txtPhone.Text));
                sqlCommand.Parameters.AddWithValue("@Email", Convert.ToString(txtEmail.Text));
                sqlCommand.Parameters.AddWithValue("@Salary", Convert.ToDecimal(txtSalary.Text));
                sqlCommand.Parameters.AddWithValue("@Id", Convert.ToInt32(Session["Id"]));
                int result = Convert.ToInt32(sqlCommand.ExecuteNonQuery());
                if (result > 0)
                {
                    ShowAlertMessage("Record Is Update Seccessfuylly.");
                    BindEmployeeData();
                    ClearControls();
                }
                else
                {
                    ShowAlertMessage("Failed");
                }
            }
            catch (Exception exception)
            {
                ShowAlertMessage("Check your input Data.!" + exception);
            }
            finally
            {
                CloseConnection();
                DisposeConnection();
            }

        }
           

        protected void btnReset_Click(object sender, EventArgs e)
        {
           ClearControls();
        }

        protected void grvEmployee_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvEmployee.PageIndex = e.NewPageIndex;
            BindEmployeeData();
        }

        protected void grvEmployee_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grvEmployee.EditIndex = -1;
            BindEmployeeData();
        }

        protected void grvEmployee_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                CreateConection();
                OpenConection();

                Label id = (Label) grvEmployee.Rows[e.RowIndex].FindControl("lblId");
                sqlCommand.CommandText = "SP_GridCrud";
                sqlCommand.Parameters.AddWithValue("@Event", "Delete");
                sqlCommand.Parameters.AddWithValue("@Id", Convert.ToInt32(id.Text));
                sqlCommand.CommandType = CommandType.StoredProcedure;
                int result = Convert.ToInt32(sqlCommand.ExecuteNonQuery());

                if (result > 0)
                {
                    ShowAlertMessage("Record Is deleted Successfully.");
                    grvEmployee.EditIndex = -1;
                    BindEmployeeData();
                }
                else
                {

                    lblMensaje.Text = "Failed";
                    lblMensaje.ForeColor = Color.Red;
                    BindEmployeeData();

                }
            }
            catch (Exception exception)
            {
                ShowAlertMessage("Check ypur input date.");
            }
            finally
            {
                CloseConnection();
                DisposeConnection();
            }
        }

        protected void grvEmployee_RowEditing(object sender, GridViewEditEventArgs e)
        {
            btnAddEmployee.Visible = false;
            btnUpdate.Visible = true;

            int rowIndex = e.NewEditIndex;
            Label empId = (Label)grvEmployee.Rows[rowIndex].FindControl("lblId");
            Session["Id"] = empId.Text;

            txtFirstName.Text = ((Label)grvEmployee.Rows[rowIndex].FindControl("lblFirstName")).Text.ToString();
            txtLastName.Text  = ((Label)grvEmployee.Rows[rowIndex].FindControl("lblLastName")).Text.ToString();
            txtPhone.Text     = ((Label)grvEmployee.Rows[rowIndex].FindControl("lblPhone")).Text.ToString();
            txtEmail.Text     = ((Label)grvEmployee.Rows[rowIndex].FindControl("lblEmail")).Text.ToString();
            txtSalary.Text    = ((Label)grvEmployee.Rows[rowIndex].FindControl("lblSalary")).Text.ToString();
        }
    }
}