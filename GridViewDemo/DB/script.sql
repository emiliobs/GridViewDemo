USE [CRUD]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 6/19/2017 3:29:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Phone] [varchar](15) NULL,
	[Email] [varchar](50) NULL,
	[Salary] [decimal](18, 2) NULL,
	[Date] [datetime] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  StoredProcedure [dbo].[SP_GridCrud]    Script Date: 6/19/2017 3:29:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GridCrud]
( 
	@Id INT=0,
	@FirstName varchar(50)=null,
	@LastName varchar(50)=null,
	@Phone varchar(15)=null,
	@Email varchar(50) = null,
	@Salary decimal = null,
	@Event varchar(10)

	)
AS
BEGIN
	 IF(@Event='Select')  
    BEGIN  
    SELECT * FROM Employee ORDER BY FirstName ASC;  
    END  
  
    ELSE IF(@Event='Add')  
    BEGIN  
    INSERT INTO Employee (FirstName,LastName,Phone,Email,Salary,Date) VALUES(@FirstName,@LastName,@Phone,@Email,@Salary,GETDATE());  
    END  
  
    ELSE IF(@Event='Update')  
    BEGIN  
    UPDATE Employee SET FirstName=@FirstName,LastName=@LastName,Phone=@Phone,Email=@Email,Salary=@Salary where Id=@Id;  
    END  
  
    ELSE  
    BEGIN  
    DELETE FROM Employee WHERE Id=@Id;  
    END  
END

GO
