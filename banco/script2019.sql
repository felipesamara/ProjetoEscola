USE [master]
GO
/****** Object:  Database [dbEscola]    Script Date: 22/06/2021 14:24:43 ******/
CREATE DATABASE [dbEscola]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbEscola', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\dbEscola.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dbEscola_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\dbEscola_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [dbEscola] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbEscola].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbEscola] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbEscola] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbEscola] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbEscola] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbEscola] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbEscola] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dbEscola] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbEscola] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbEscola] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbEscola] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbEscola] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbEscola] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbEscola] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbEscola] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbEscola] SET  DISABLE_BROKER 
GO
ALTER DATABASE [dbEscola] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbEscola] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbEscola] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbEscola] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbEscola] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbEscola] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbEscola] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbEscola] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [dbEscola] SET  MULTI_USER 
GO
ALTER DATABASE [dbEscola] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbEscola] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbEscola] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbEscola] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [dbEscola] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [dbEscola] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [dbEscola] SET QUERY_STORE = OFF
GO
USE [dbEscola]
GO
/****** Object:  Table [dbo].[tbAluno]    Script Date: 22/06/2021 14:24:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbAluno](
	[cdAluno] [int] IDENTITY(1,1) NOT NULL,
	[nmAluno] [varchar](50) NULL,
	[valorMensalidade] [money] NULL,
	[vencimentoMensalidade] [datetime] NULL,
 CONSTRAINT [PK_tbAluno] PRIMARY KEY CLUSTERED 
(
	[cdAluno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbAlunoProfessor]    Script Date: 22/06/2021 14:24:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbAlunoProfessor](
	[cdAlunoProfessor] [int] IDENTITY(1,1) NOT NULL,
	[cdAluno] [int] NULL,
	[cdProfessor] [int] NULL,
 CONSTRAINT [PK_tbAlunoProfessor] PRIMARY KEY CLUSTERED 
(
	[cdAlunoProfessor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbProfessor]    Script Date: 22/06/2021 14:24:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbProfessor](
	[cdProfessor] [int] IDENTITY(1,1) NOT NULL,
	[nmProfessor] [varchar](50) NULL,
	[nmMateria] [varchar](50) NULL,
 CONSTRAINT [PK_tbProfessor] PRIMARY KEY CLUSTERED 
(
	[cdProfessor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbAlunoProfessor]  WITH CHECK ADD  CONSTRAINT [FK_tbAlunoProfessor_tbAluno] FOREIGN KEY([cdAluno])
REFERENCES [dbo].[tbAluno] ([cdAluno])
GO
ALTER TABLE [dbo].[tbAlunoProfessor] CHECK CONSTRAINT [FK_tbAlunoProfessor_tbAluno]
GO
ALTER TABLE [dbo].[tbAlunoProfessor]  WITH CHECK ADD  CONSTRAINT [FK_tbAlunoProfessor_tbProfessor] FOREIGN KEY([cdProfessor])
REFERENCES [dbo].[tbProfessor] ([cdProfessor])
GO
ALTER TABLE [dbo].[tbAlunoProfessor] CHECK CONSTRAINT [FK_tbAlunoProfessor_tbProfessor]
GO
USE [master]
GO
ALTER DATABASE [dbEscola] SET  READ_WRITE 
GO
