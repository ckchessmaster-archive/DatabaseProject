USE [master]
GO
/****** Object:  Database [ECS3]    Script Date: 12/6/2017 1:00:03 PM ******/
CREATE DATABASE [ECS3]
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ECS3].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ECS3] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ECS3] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ECS3] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ECS3] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ECS3] SET ARITHABORT OFF 
GO
ALTER DATABASE [ECS3] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ECS3] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ECS3] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ECS3] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ECS3] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ECS3] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ECS3] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ECS3] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ECS3] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ECS3] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ECS3] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [ECS3] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ECS3] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [ECS3] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ECS3] SET  MULTI_USER 
GO
ALTER DATABASE [ECS3] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ECS3] SET ENCRYPTION ON
GO
ALTER DATABASE [ECS3] SET QUERY_STORE = ON
GO
ALTER DATABASE [ECS3] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO)
GO
USE [ECS3]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 12/6/2017 1:00:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	
GO
/****** Object:  Table [dbo].[Actor]    Script Date: 12/6/2017 1:00:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actor](
	[ActorID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Birthday] [date] NULL,
	[BirthCity] [varchar](50) NULL,
	[BirthState] [varchar](50) NULL,
	[BirthCountry] [varchar](50) NULL,
 CONSTRAINT [PK_Actors] PRIMARY KEY CLUSTERED 
(
	[ActorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Film]    Script Date: 12/6/2017 1:00:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Film](
	[FilmID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[GenreID] [int] NULL,
	[RatingID] [int] NOT NULL,
	[Year] [date] NULL,
	[Released] [date] NULL,
	[Runtime] [varchar](50) NULL,
	[imdbID] [varchar](50) NULL,
	[Poster] [varchar](200) NULL,
 CONSTRAINT [PK_Films] PRIMARY KEY CLUSTERED 
(
	[FilmID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[FilmActor]    Script Date: 12/6/2017 1:00:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilmActor](
	[FilmID] [int] NOT NULL,
	[ActorID] [int] NOT NULL,
 CONSTRAINT [PK_FilmActor_1] PRIMARY KEY CLUSTERED 
(
	[FilmID] ASC,
	[ActorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[FilmProducer]    Script Date: 12/6/2017 1:00:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilmProducer](
	[FilmID] [int] NOT NULL,
	[ProducerID] [int] NOT NULL,
 CONSTRAINT [PK_FilmProducer] PRIMARY KEY CLUSTERED 
(
	[FilmID] ASC,
	[ProducerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Genre]    Script Date: 12/6/2017 1:00:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genre](
	[GenreID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Genres] PRIMARY KEY CLUSTERED 
(
	[GenreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Producer]    Script Date: 12/6/2017 1:00:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producer](
	[ProducerID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Producers] PRIMARY KEY CLUSTERED 
(
	[ProducerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Rating]    Script Date: 12/6/2017 1:00:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rating](
	[RatingID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Rating] PRIMARY KEY CLUSTERED 
(
	[RatingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Role]    Script Date: 12/6/2017 1:00:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[FilmID] [int] NOT NULL,
	[ActorID] [int] NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 12/6/2017 1:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET IDENTITY_INSERT [dbo].[Actor] ON 

INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (1, N'Harrison', N'Ford', CAST(N'1942-07-13' AS Date), N'Chicago', N'Illinois', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (2, N'Rutger', N'Hauer', CAST(N'1944-01-23' AS Date), N'Breukelen', N'Utrecht', N'Netherlands')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (3, N'Sean', N'Young', CAST(N'1959-09-20' AS Date), N'Louisville', N'Kentucky', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (4, N'Edward James', N'Olmos', CAST(N'1947-02-24' AS Date), N'Los Angeles', N'California', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (5, N'M. Emmet', N'Walsh', CAST(N'1935-03-22' AS Date), N'Ogdensburg', N'New York', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (6, N'Mark', N'Hamill', CAST(N'1951-09-25' AS Date), N'Oakland', N'California', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (7, N'Carrie', N'Fisher', CAST(N'1956-08-21' AS Date), N'Burbank', N'California', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (8, N'Peter', N'Cushing', CAST(N'1913-05-26' AS Date), N'Kenley', N'Surrey', N'England')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (9, N'Alec', N'Guinness', CAST(N'1914-04-02' AS Date), N'Marylebone', N'London', N'England')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (10, N'Kate', N'Capshaw', CAST(N'1953-11-03' AS Date), N'Fort Worth', N'Texas', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (11, N'Jonathan', N'Ke Quan', CAST(N'1971-08-20' AS Date), N'Saigon', N'', N'Vietnam')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (12, N'Amrish', N'Puri', CAST(N'1932-06-22' AS Date), N'Nawanshahr', N'Punjab', N'India')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (13, N'Roshan', N'Seth', CAST(N'1942-04-02' AS Date), N'Patna', N'Bihar', N'India')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (14, N'Anne', N'Archer', CAST(N'1947-08-24' AS Date), N'Los Angeles', N'California', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (15, N'Patrick', N'Bergin', CAST(N'1951-02-04' AS Date), N'Dublin', N'', N'Ireland')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (16, N'Sean', N'Bean', CAST(N'1959-04-17' AS Date), N'Sheffield', N'South Yorkshire', N'England')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (17, N'Thora', N'Birch', CAST(N'1982-03-11' AS Date), N'Los Angeles', N'California', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (18, N'Adam', N'Driver', CAST(N'1983-11-19' AS Date), N'San Diego', N'California', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (19, N'Daisy', N'Ridley', CAST(N'1992-04-10' AS Date), N'London', N'', N'England')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (20, N'John', N'Boyega', CAST(N'1992-05-17' AS Date), N'London', N'', N'England')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (21, N'Oscar', N'Isaac', CAST(N'1979-05-09' AS Date), N'Guatemala City', N'', N'Guatemala')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (22, N'John', N'Travolta', CAST(N'1954-02-18' AS Date), N'Englewood', N'New Jersey', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (23, N'Tim', N'Roth', CAST(N'1961-05-14' AS Date), N'London', N'', N'England')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (24, N'Amanda', N'Plummer', CAST(N'1957-05-23' AS Date), N'New York City', N'New York', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (25, N'Samuel L', N'Jackson', CAST(N'1948-12-21' AS Date), N'Washington', N'District of Columbia', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (26, N'Phil', N'LaMarr', CAST(N'1967-01-24' AS Date), N'Los Angeles', N'California', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (27, N'Uma', N'Thurman', CAST(N'1970-04-29' AS Date), N'Boston', N'Massachusetts', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (28, N'Lucy', N'Liu', CAST(N'1968-12-02' AS Date), N'New York City', N'New York', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (29, N'Vivica A', N'Fox', CAST(N'1964-07-30' AS Date), N'South Bend', N'Indiana', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (30, N'Daryl', N'Hannah', CAST(N'1960-12-03' AS Date), N'Chicago', N'Illinois', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (31, N'David', N'Carradine', CAST(N'1936-12-08' AS Date), N'Los Angeles', N'California', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (32, N'Harvey', N'Keitel', CAST(N'1939-05-13' AS Date), N'Brooklyn', N'New York', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (33, N'Michael', N'Madsen', CAST(N'1957-09-25' AS Date), N'Chicago', N'Illinois', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (34, N'Quentin', N'Tarantino', CAST(N'1963-05-27' AS Date), N'Knoxville', N'Tennessee', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (35, N'Steve', N'Buscemi', CAST(N'1957-12-13' AS Date), N'Brooklyn', N'New York', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (36, N'Pam', N'Grier', CAST(N'1949-05-26' AS Date), N'Winston-Salem', N'North Carolina', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (37, N'Robert', N'Forster', CAST(N'1941-07-13' AS Date), N'Rochester', N'New York', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (38, N'Bridget', N'Fonda', CAST(N'1964-01-27' AS Date), N'Los Angeles', N'California', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (39, N'Michael', N'Keaton', CAST(N'1951-09-05' AS Date), N'Coraoplolis', N'Pennsylvania', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (40, N'Leonardo', N'DeCaprio', CAST(N'1974-11-11' AS Date), N'Los Angeles', N'California', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (41, N'Joseph', N'Gordon-Levitt', CAST(N'1981-02-17' AS Date), N'Los Angeles', N'California', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (42, N'Ellen', N'Page', CAST(N'1987-02-21' AS Date), N'Halifax', N'Nova Scotia', N'Canada')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (43, N'Tom', N'Hardy', CAST(N'1977-09-15' AS Date), N'Hammersmith', N'London', N'England')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (44, N'Ken', N'Watanabe', CAST(N'1959-10-21' AS Date), N'Uonuma', N'', N'Japan')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (45, N'Kate', N'Winslet', CAST(N'1975-10-05' AS Date), N'Reading', N'Berkshire', N'England')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (46, N'Billy', N'Zane', CAST(N'1966-02-24' AS Date), N'Chicago', N'Illinois', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (47, N'Kathy', N'Bates', CAST(N'1948-06-28' AS Date), N'Memphis', N'Tennessee', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (48, N'Frances', N'Fisher', CAST(N'1952-05-11' AS Date), N'Milford-on-the-Sea', N'Hampshire', N'England')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (49, N'Elijah', N'Wood', CAST(N'1981-01-28' AS Date), N'Cedar Rapids', N'Iowa', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (50, N'Sean', N'Astin', CAST(N'1971-02-25' AS Date), N'Santa Monica', N'California', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (51, N'Orlando', N'Bloom', CAST(N'1977-01-13' AS Date), N'Canterbury', N'Kent', N'England')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (52, N'Billy', N'Boyd', CAST(N'1968-08-28' AS Date), N'Glasgow', N'Scotland', N'UK')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (53, N'Ian', N'Holm', CAST(N'1931-09-12' AS Date), N'Goodmayes', N'Essex', N'England')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (54, N'Matthew', N'Modine', CAST(N'1959-03-22' AS Date), N'Loma Linda', N'California', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (55, N'Adam', N'Baldwin', CAST(N'1962-02-27' AS Date), N'Winnetka', N'Illinois', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (56, N'Vincent', N'DOnofrio', CAST(N'1959-06-30' AS Date), N'New York City', N'New York', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (57, N'Dorian', N'Harewood', CAST(N'1950-08-06' AS Date), N'Daton', N'Ohio', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (58, N'Arliss', N'Howard', CAST(N'1954-10-18' AS Date), N'Independence', N'Missouri', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (59, N'Christian', N'Bale', CAST(N'1974-01-30' AS Date), N'Haverfordwest', N'Pembrokeshire', N'Wales')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (60, N'Michael', N'Caine', CAST(N'1933-03-14' AS Date), N'Rotherhithe', N'London', N'England')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (61, N'Liam', N'Neeson', CAST(N'1952-06-07' AS Date), N'Ballymena', N'Co. Antrim', N'Ireland')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (62, N'Katie', N'Holmes', CAST(N'1978-12-18' AS Date), N'Toledo', N'Ohio', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (63, N'Gary', N'Oldman', CAST(N'1958-03-21' AS Date), N'New Cross', N'London', N'England')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (64, N'Heath', N'Ledger', CAST(N'1979-04-04' AS Date), N'Perth', N'Western Australia', N'Australia')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (65, N'Michael', N'Fox', CAST(N'1961-06-09' AS Date), N'Edmonton', N'Alberta', N'Canada')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (66, N'Christopher', N'Lloyd', CAST(N'1938-10-22' AS Date), N'Stamford', N'Connecticut', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (67, N'Lea', N'Thompson', CAST(N'1961-05-31' AS Date), N'Rochester', N'Minnesota', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (68, N'Crispin', N'Glover', CAST(N'1964-04-20' AS Date), N'New York City', N'New York', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (69, N'Thomas', N'Wilson', CAST(N'1959-04-15' AS Date), N'Philadelphia', N'Pennsylvania', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (70, N'Daniel', N'Radcliffe', CAST(N'1989-07-23' AS Date), N'London', N'', N'England')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (71, N'Emma', N'Watson', CAST(N'1990-04-15' AS Date), N'Paris', N'Île-de-France', N'France')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (72, N'Rupert', N'Grint', CAST(N'1988-08-24' AS Date), N'Harlow', N'', N'England')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (73, N'Robbie', N'Coltrane', CAST(N'1950-03-30' AS Date), N'Rutherglen', N'', N'Scotland')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (74, N'Richard', N'Harris', CAST(N'1930-10-01' AS Date), N'Limerick', N'', N'Ireland')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (75, N'Alan', N'Rickman', CAST(N'1946-02-21' AS Date), N'London', N'', N'England')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (76, N'Michael', N'Gambon', CAST(N'1940-10-19' AS Date), N'Dublin', N'', N'Ireland')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (77, N'Eddie', N'Redmayne', CAST(N'1982-01-06' AS Date), N'London', N'', N'England')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (78, N'Katherine', N'Watersoton', CAST(N'1980-03-03' AS Date), N'London', N'', N'England')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (79, N'Ezra', N'Miller', CAST(N'1992-09-30' AS Date), N'Hoboken', N'New Jersey', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (80, N'Colin', N'Farrell', CAST(N'1976-05-31' AS Date), N'Dublin', N'', N'Ireland')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (81, N'Dan', N'Fogler', CAST(N'1976-08-20' AS Date), N'New York', N'New York', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (82, N'Alison', N'Sudol', CAST(N'1984-12-23' AS Date), N'Seattle', N'Washington', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (83, N'Johnny', N'Depp', CAST(N'1963-06-09' AS Date), N'Owensboro', N'Kentucky', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (84, N'Jennifer', N'Lawrence', CAST(N'1990-08-15' AS Date), N'Louisville', N'Kentucky', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (85, N'Chris', N'Pratt', CAST(N'1979-06-21' AS Date), N'Virginia', N'Minnesota', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (86, N'Michael', N'Sheen', CAST(N'1969-02-05' AS Date), N'Newport', N'', N'Wales')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (87, N'Laurence', N'Fishburne', CAST(N'1961-07-30' AS Date), N'Augusta', N'Georgia', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (88, N'Tom', N'Hanks', CAST(N'1956-07-09' AS Date), N'Concord', N'California', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (89, N'Karen', N'Gillan', CAST(N'1987-11-28' AS Date), N'Inverness', N'', N'Scotland')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (90, N'Glenne', N'Headly', CAST(N'1955-03-13' AS Date), N'Santa Monica', N'California', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (91, N'Bill', N'Paxton', CAST(N'1955-05-17' AS Date), N'Los Angeles', N'California', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (92, N'Ellar', N'Coltrane', CAST(N'1994-08-24' AS Date), N'Austin', N'Texas', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (93, N'Keanu', N'Reeves', CAST(N'1964-09-02' AS Date), N'Beirut', N'', N'Lebanon')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (94, N'Carrie-Anne', N'Moss', CAST(N'1967-08-21' AS Date), N'Vancouver', N'British Columbia', N'Canada')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (95, N'Hugo', N'Weaving', CAST(N'1960-04-04' AS Date), N'Ibadan', N'', N'Nigeria')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (96, N'Gloria', N'Foster', CAST(N'1933-11-15' AS Date), N'Chicago', N'Illinois', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (97, N'Joe', N'Pantoliano', CAST(N'1951-09-12' AS Date), N'Hoboken', N'New Jersey', N'USA')
INSERT [dbo].[Actor] ([ActorID], [FirstName], [LastName], [Birthday], [BirthCity], [BirthState], [BirthCountry]) VALUES (98, N'Mary', N'Alice', CAST(N'1941-12-03' AS Date), N'Indianola', N'Mississippi', N'USA')
SET IDENTITY_INSERT [dbo].[Actor] OFF
GO
SET IDENTITY_INSERT [dbo].[Film] ON 

INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (1, N'Blade Runner', 1, 1, CAST(N'1982-01-01' AS Date), CAST(N'1982-06-25' AS Date), N'117 min', N'tt0083658', N'https://images-na.ssl-images-amazon.com/images/M/MV5BNzQzMzJhZTEtOWM4NS00MTdhLTg0YjgtMjM4MDRkZjUwZDBlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (2, N'Star Wars: Episode IV - A New Hope', 2, 2, CAST(N'1977-01-01' AS Date), CAST(N'1977-05-25' AS Date), N'123 min', N'tt0076759', N'https://images-na.ssl-images-amazon.com/images/M/MV5BYTUwNTdiMzMtNThmNS00ODUzLThlMDMtMTM5Y2JkNWJjOGQ2XkEyXkFqcGdeQXVyNzQ1ODk3MTQ@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (3, N'Indiana Jones and the Temple of Doom', 3, 3, CAST(N'1984-01-01' AS Date), CAST(N'1984-05-23' AS Date), N'118 min', N'tt0087469', N'https://images-na.ssl-images-amazon.com/images/M/MV5BMTMyNzI4OTA5OV5BMl5BanBnXkFtZTcwMDQ2MjAxNA@@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (4, N'Patriot Games', 3, 4, CAST(N'1992-01-01' AS Date), CAST(N'1992-06-05' AS Date), N'117 min', N'tt0105112', N'https://images-na.ssl-images-amazon.com/images/M/MV5BMjA3OTA0NjI0Nl5BMl5BanBnXkFtZTgwNjUwODQxMTE@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (5, N'Star Wars: The Force Awakens', 2, 5, CAST(N'2015-01-01' AS Date), CAST(N'2015-12-18' AS Date), N'136 min', N'tt2488496', N'https://images-na.ssl-images-amazon.com/images/M/MV5BOTAzODEzNDAzMl5BMl5BanBnXkFtZTgwMDU1MTgzNzE@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (6, N'Pulp Fiction', 4, 6, CAST(N'1994-01-01' AS Date), CAST(N'1994-10-14' AS Date), N'154 min', N'tt0110912', N'https://images-na.ssl-images-amazon.com/images/M/MV5BMTkxMTA5OTAzMl5BMl5BanBnXkFtZTgwNjA5MDc3NjE@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (7, N'Kill Bill: Vol. 1', 3, 7, CAST(N'2003-01-01' AS Date), CAST(N'2003-10-10' AS Date), N'111 min', N'tt0266697', N'https://images-na.ssl-images-amazon.com/images/M/MV5BYTczMGFiOWItMjA3Mi00YTU5LWIwMDgtYTEzNjRkNDkwMTE2XkEyXkFqcGdeQXVyNzQ1ODk3MTQ@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (8, N'Reservoir Dogs', 4, 8, CAST(N'1992-01-01' AS Date), CAST(N'1992-09-02' AS Date), N'99 min', N'tt0105236', N'https://images-na.ssl-images-amazon.com/images/M/MV5BZmExNmEwYWItYmQzOS00YjA5LTk2MjktZjEyZDE1Y2QxNjA1XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (9, N'Jackie Brown', 4, 4, CAST(N'1997-01-01' AS Date), CAST(N'1997-12-25' AS Date), N'154 min', N'tt0119396', N'https://images-na.ssl-images-amazon.com/images/M/MV5BNmY5ODRmYTItNWU0Ni00MWE3LTgyYzUtYjZlN2Q5YTcyM2NmXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (10, N'Inception', 3, 9, CAST(N'2010-01-01' AS Date), CAST(N'2010-07-16' AS Date), N'148 min', N'tt1375666', N'https://images-na.ssl-images-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (11, N'Titantic', 5, 9, CAST(N'1997-01-01' AS Date), CAST(N'1997-12-19' AS Date), N'194 min', N'tt0120338', N'https://images-na.ssl-images-amazon.com/images/M/MV5BMDdmZGU3NDQtY2E5My00ZTliLWIzOTUtMTY4ZGI1YjdiNjk3XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (12, N'The Lord of the Rings: The Fellowship of the Ring', 2, 2, CAST(N'2001-01-01' AS Date), CAST(N'2001-12-19' AS Date), N'178 min', N'tt0120737', N'https://images-na.ssl-images-amazon.com/images/M/MV5BN2EyZjM3NzUtNWUzMi00MTgxLWI0NTctMzY4M2VlOTdjZWRiXkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (13, N'The Lord of the Rings: The Return of the King', 2, 6, CAST(N'2003-01-01' AS Date), CAST(N'2003-12-17' AS Date), N'201 min', N'tt0167260', N'https://images-na.ssl-images-amazon.com/images/M/MV5BYWY1ZWQ5YjMtMDE0MS00NWIzLWE1M2YtODYzYTk2OTNlYWZmXkEyXkFqcGdeQXVyNDUyOTg3Njg@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (14, N'The Lord of the Rings: The Two Towers', 2, 10, CAST(N'2002-01-01' AS Date), CAST(N'2002-12-18' AS Date), N'179 min', N'tt0167261', N'https://images-na.ssl-images-amazon.com/images/M/MV5BMDY0NmI4ZjctN2VhZS00YzExLTkyZGItMTJhOTU5NTg4MDU4XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (15, N'Full Metal Jacket', 6, 11, CAST(N'1987-01-01' AS Date), CAST(N'1987-07-10' AS Date), N'116 min', N'tt0093058', N'https://images-na.ssl-images-amazon.com/images/M/MV5BNzc2ZThkOGItZGY5YS00MDYwLTkyOTAtNDRmZWIwMGRhYTc0L2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (16, N'Batman Begins', 3, 12, CAST(N'2005-01-01' AS Date), CAST(N'2005-06-15' AS Date), N'140 min', N'tt0372784', N'https://images-na.ssl-images-amazon.com/images/M/MV5BYzc4ODgyZmYtMGFkZC00NGQyLWJiMDItMmFmNjJiZjcxYzVmXkEyXkFqcGdeQXVyNDYyMDk5MTU@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (17, N'The Dark Knight', 3, 13, CAST(N'2008-01-01' AS Date), CAST(N'2008-07-18' AS Date), N'152 min', N'tt0468569', N'https://images-na.ssl-images-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (18, N'The Dark Knight Rises', 3, 14, CAST(N'2012-01-01' AS Date), CAST(N'2012-07-20' AS Date), N'164 min', N'tt1345836', N'https://images-na.ssl-images-amazon.com/images/M/MV5BMTk4ODQzNDY3Ml5BMl5BanBnXkFtZTcwODA0NTM4Nw@@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (19, N'Back to the Future', 2, 15, CAST(N'1985-01-01' AS Date), CAST(N'1985-07-03' AS Date), N'116 min', N'tt0088763', N'https://images-na.ssl-images-amazon.com/images/M/MV5BZmU0M2Y1OGUtZjIxNi00ZjBkLTg1MjgtOWIyNThiZWIwYjRiXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (20, N'Harry Potter and the Sorcerer''s Stone', 7, 4, CAST(N'2001-01-01' AS Date), CAST(N'2001-11-16' AS Date), N'152 min', N'tt0241527', N'https://images-na.ssl-images-amazon.com/images/M/MV5BNjQ3NWNlNmQtMTE5ZS00MDdmLTlkZjUtZTBlM2UxMGFiMTU3XkEyXkFqcGdeQXVyNjUwNzk3NDc@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (21, N'Harry Potter and the Chamber of Secrets', 7, 16, CAST(N'2002-01-01' AS Date), CAST(N'2002-11-15' AS Date), N'161 min', N'tt0295297', N'
https://images-na.ssl-images-amazon.com/images/M/MV5BMTcxODgwMDkxNV5BMl5BanBnXkFtZTYwMDk2MDg3._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (22, N'Harry Potter and the Prisoner of Azkaban', 7, 13, CAST(N'2004-01-01' AS Date), CAST(N'2004-06-04' AS Date), N'142 min', N'tt0304141', N'https://images-na.ssl-images-amazon.com/images/M/MV5BMTY4NTIwODg0N15BMl5BanBnXkFtZTcwOTc0MjEzMw@@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (23, N'Harry Potter and the Goblet of Fire', 7, 5, CAST(N'2005-01-01' AS Date), CAST(N'2005-11-18' AS Date), N'157 min', N'tt0330373', N'https://images-na.ssl-images-amazon.com/images/M/MV5BMTI1NDMyMjExOF5BMl5BanBnXkFtZTcwOTc4MjQzMQ@@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (24, N'Harry Potter and the Order of the Phoenix', 7, 17, CAST(N'2007-01-01' AS Date), CAST(N'2007-07-11' AS Date), N'138 min', N'tt0373889', N'https://images-na.ssl-images-amazon.com/images/M/MV5BMTM0NTczMTUzOV5BMl5BanBnXkFtZTYwMzIxNTg3._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (25, N'Harry Potter and the Half-Blood Prince', 7, 14, CAST(N'2009-01-01' AS Date), CAST(N'2009-07-15' AS Date), N'153 min', N'tt0417741', N'https://images-na.ssl-images-amazon.com/images/M/MV5BNzU3NDg4NTAyNV5BMl5BanBnXkFtZTcwOTg2ODg1Mg@@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (26, N'Harry Potter and the Deathly Hallows: Part 1', 7, 18, CAST(N'2010-01-01' AS Date), CAST(N'2010-11-19' AS Date), N'146 min', N'tt0926084', N'https://images-na.ssl-images-amazon.com/images/M/MV5BMTQ2OTE1Mjk0N15BMl5BanBnXkFtZTcwODE3MDAwNA@@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (27, N'Harry Potter and the Deathly Hallows: Part 2', 7, 19, CAST(N'2011-01-01' AS Date), CAST(N'2011-07-15' AS Date), N'130 min', N'tt1201607', N'https://images-na.ssl-images-amazon.com/images/M/MV5BMjIyZGU4YzUtNDkzYi00ZDRhLTljYzctYTMxMDQ4M2E0Y2YxXkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (28, N'Fantastic Beasts and Where to Find Them', 7, 20, CAST(N'2016-01-01' AS Date), CAST(N'2016-11-18' AS Date), N'133 min', N'tt3183660', N'https://images-na.ssl-images-amazon.com/images/M/MV5BMjMxOTM1OTI4MV5BMl5BanBnXkFtZTgwODE5OTYxMDI@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (29, N'Passengers', 1, 21, CAST(N'2016-01-01' AS Date), CAST(N'2016-12-21' AS Date), N'116 min', N'tt1355644', N'https://images-na.ssl-images-amazon.com/images/M/MV5BMTk4MjU3MDIzOF5BMl5BanBnXkFtZTgwMjM2MzY2MDI@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (30, N'The Circle', 4, 22, CAST(N'2017-01-01' AS Date), CAST(N'2017-04-28' AS Date), N'110 min', N'tt4287320', N'https://images-na.ssl-images-amazon.com/images/M/MV5BMjY2OTM2Njc3Ml5BMl5BanBnXkFtZTgwNDgzODU3MTI@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (31, N'The Matrix', 1, 23, CAST(N'1999-01-01' AS Date), CAST(N'1999-03-31' AS Date), N'136 min', N'tt0133093', N'https://images-na.ssl-images-amazon.com/images/M/MV5BNzQzOTk3OTAtNDQ0Zi00ZTVkLWI0MTEtMDllZjNkYzNjNTc4L2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (32, N'The Matrix Reloaded', 1, 24, CAST(N'2003-01-01' AS Date), CAST(N'2003-05-15' AS Date), N'136 min', N'tt0234215', N'https://images-na.ssl-images-amazon.com/images/M/MV5BYzM3OGVkMjMtNDk3NS00NDk5LWJjZjUtYTVkZTIyNmQxNDMxXkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_SX300.jpg')
INSERT [dbo].[Film] ([FilmID], [Name], [GenreID], [RatingID], [Year], [Released], [Runtime], [imdbID], [Poster]) VALUES (33, N'Matrix Revolutions', 1, 25, CAST(N'2003-01-01' AS Date), CAST(N'2003-11-05' AS Date), N'129 min', N'tt0242653', N'https://images-na.ssl-images-amazon.com/images/M/MV5BNzNlZTZjMDctZjYwNi00NzljLWIwN2QtZWZmYmJiYzQ0MTk2XkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_SX300.jpg')
SET IDENTITY_INSERT [dbo].[Film] OFF
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (1, 1)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (1, 2)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (1, 3)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (1, 4)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (1, 5)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (2, 1)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (2, 6)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (2, 7)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (2, 8)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (2, 9)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (3, 1)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (3, 10)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (3, 11)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (3, 12)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (3, 13)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (4, 1)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (4, 14)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (4, 15)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (4, 16)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (4, 17)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (5, 1)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (5, 6)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (5, 7)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (5, 18)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (5, 19)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (5, 20)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (5, 21)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (6, 22)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (6, 23)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (6, 24)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (6, 25)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (6, 26)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (7, 27)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (7, 28)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (7, 29)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (7, 30)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (7, 31)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (8, 23)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (8, 32)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (8, 33)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (8, 34)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (8, 35)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (9, 25)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (9, 36)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (9, 37)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (9, 38)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (9, 39)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (10, 40)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (10, 41)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (10, 42)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (10, 43)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (10, 44)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (11, 40)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (11, 45)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (11, 46)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (11, 47)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (11, 48)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (12, 49)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (12, 50)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (12, 51)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (12, 52)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (12, 53)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (13, 49)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (13, 50)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (13, 51)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (13, 52)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (13, 53)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (14, 49)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (14, 50)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (14, 51)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (14, 52)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (14, 53)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (15, 54)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (15, 55)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (15, 56)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (15, 57)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (15, 58)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (16, 59)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (16, 60)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (16, 61)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (16, 62)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (16, 63)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (17, 59)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (17, 60)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (17, 62)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (17, 63)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (17, 64)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (18, 43)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (18, 59)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (18, 60)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (18, 62)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (18, 63)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (19, 65)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (19, 66)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (19, 67)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (19, 68)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (19, 69)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (20, 70)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (20, 71)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (20, 72)
GO
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (20, 73)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (20, 74)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (20, 75)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (21, 70)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (21, 71)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (21, 72)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (21, 73)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (21, 74)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (21, 75)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (22, 70)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (22, 71)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (22, 72)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (22, 73)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (22, 75)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (22, 76)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (23, 70)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (23, 71)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (23, 72)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (23, 73)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (23, 75)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (23, 76)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (24, 70)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (24, 71)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (24, 72)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (24, 73)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (24, 75)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (24, 76)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (25, 70)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (25, 71)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (25, 72)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (25, 73)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (25, 75)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (25, 76)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (26, 70)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (26, 71)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (26, 72)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (26, 73)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (26, 75)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (26, 76)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (27, 70)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (27, 71)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (27, 72)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (27, 73)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (27, 75)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (27, 76)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (28, 77)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (28, 78)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (28, 79)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (28, 80)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (28, 81)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (28, 82)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (28, 83)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (29, 84)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (29, 85)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (29, 86)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (29, 87)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (30, 71)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (30, 88)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (30, 89)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (30, 90)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (30, 91)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (30, 92)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (31, 87)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (31, 93)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (31, 94)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (31, 95)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (31, 96)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (31, 97)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (32, 87)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (32, 93)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (32, 94)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (32, 95)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (32, 96)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (33, 87)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (33, 93)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (33, 94)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (33, 95)
INSERT [dbo].[FilmActor] ([FilmID], [ActorID]) VALUES (33, 98)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (1, 1)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (2, 2)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (3, 3)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (4, 4)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (5, 5)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (6, 6)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (7, 6)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (8, 6)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (9, 6)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (10, 7)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (11, 8)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (12, 9)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (13, 9)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (14, 9)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (15, 10)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (16, 7)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (17, 7)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (18, 7)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (19, 11)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (20, 12)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (21, 12)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (22, 13)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (23, 14)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (24, 15)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (25, 15)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (26, 15)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (27, 15)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (28, 15)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (29, 16)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (30, 17)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (31, 18)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (32, 18)
INSERT [dbo].[FilmProducer] ([FilmID], [ProducerID]) VALUES (33, 18)
SET IDENTITY_INSERT [dbo].[Genre] ON 

INSERT [dbo].[Genre] ([GenreID], [Name]) VALUES (1, N'Sci-Fi')
INSERT [dbo].[Genre] ([GenreID], [Name]) VALUES (2, N'Adventure')
INSERT [dbo].[Genre] ([GenreID], [Name]) VALUES (3, N'Action')
INSERT [dbo].[Genre] ([GenreID], [Name]) VALUES (4, N'Drama')
INSERT [dbo].[Genre] ([GenreID], [Name]) VALUES (5, N'Romance')
INSERT [dbo].[Genre] ([GenreID], [Name]) VALUES (6, N'War')
INSERT [dbo].[Genre] ([GenreID], [Name]) VALUES (7, N'Fantasy')
SET IDENTITY_INSERT [dbo].[Genre] OFF
SET IDENTITY_INSERT [dbo].[Producer] ON 

INSERT [dbo].[Producer] ([ProducerID], [FirstName], [LastName]) VALUES (1, N'Ridley', N'Scott')
INSERT [dbo].[Producer] ([ProducerID], [FirstName], [LastName]) VALUES (2, N'George', N'Lucas')
INSERT [dbo].[Producer] ([ProducerID], [FirstName], [LastName]) VALUES (3, N'Steven', N'Spielberg')
INSERT [dbo].[Producer] ([ProducerID], [FirstName], [LastName]) VALUES (4, N'Phillip', N'Noyce')
INSERT [dbo].[Producer] ([ProducerID], [FirstName], [LastName]) VALUES (5, N'J.J', N'Abrams')
INSERT [dbo].[Producer] ([ProducerID], [FirstName], [LastName]) VALUES (6, N'Quentin', N'Tarantino')
INSERT [dbo].[Producer] ([ProducerID], [FirstName], [LastName]) VALUES (7, N'Nolan', N'Christopher')
INSERT [dbo].[Producer] ([ProducerID], [FirstName], [LastName]) VALUES (8, N'James', N'Cameron')
INSERT [dbo].[Producer] ([ProducerID], [FirstName], [LastName]) VALUES (9, N'Jackson', N'Peter')
INSERT [dbo].[Producer] ([ProducerID], [FirstName], [LastName]) VALUES (10, N'Kubrick', N'Stanley')
INSERT [dbo].[Producer] ([ProducerID], [FirstName], [LastName]) VALUES (11, N'Zemeckis', N'Robert')
INSERT [dbo].[Producer] ([ProducerID], [FirstName], [LastName]) VALUES (12, N'Chris', N'Columbus')
INSERT [dbo].[Producer] ([ProducerID], [FirstName], [LastName]) VALUES (13, N'Alfonso', N'Cuarón')
INSERT [dbo].[Producer] ([ProducerID], [FirstName], [LastName]) VALUES (14, N'Mike', N'Newell')
INSERT [dbo].[Producer] ([ProducerID], [FirstName], [LastName]) VALUES (15, N'David', N'Yates')
INSERT [dbo].[Producer] ([ProducerID], [FirstName], [LastName]) VALUES (16, N'Morten', N'Tyldum')
INSERT [dbo].[Producer] ([ProducerID], [FirstName], [LastName]) VALUES (17, N'James', N'Ponsoldt')
INSERT [dbo].[Producer] ([ProducerID], [FirstName], [LastName]) VALUES (18, N'Lana', N'Wachowski')
SET IDENTITY_INSERT [dbo].[Producer] OFF
SET IDENTITY_INSERT [dbo].[Rating] ON 

INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (1, N'89')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (2, N'92')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (3, N'57')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (4, N'64')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (5, N'81')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (6, N'94')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (7, N'69')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (8, N'79')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (9, N'74')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (10, N'88')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (11, N'76')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (12, N'70')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (13, N'82')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (14, N'78')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (15, N'86')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (16, N'63')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (17, N'71')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (18, N'65')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (19, N'87')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (20, N'66')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (21, N'41')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (22, N'43')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (23, N'73')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (24, N'62')
INSERT [dbo].[Rating] ([RatingID], [Name]) VALUES (25, N'47')
SET IDENTITY_INSERT [dbo].[Rating] OFF
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (1, N'Rick Deckard', 1, 1)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (2, N'Roy Batty', 1, 2)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (3, N'Rachael', 1, 3)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (4, N'Gaff', 1, 4)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (5, N'Bryant', 1, 5)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (6, N'Han Solo', 2, 1)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (7, N'Luke Skywalker', 2, 6)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (8, N'Princess Leia Organa', 2, 7)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (9, N'Grand Moff Tarkin', 2, 8)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (10, N'Ben Obi-Wan Kenobi', 2, 9)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (11, N'Indiana Jones', 3, 1)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (12, N'Willie Scott', 3, 10)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (13, N'Short Round', 3, 11)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (14, N'Mola Ram', 3, 12)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (15, N'Chattar Lal', 3, 13)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (16, N'Jack Ryan', 4, 1)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (17, N'Cathy Ryan', 4, 14)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (18, N'Kevin ODonnell', 4, 15)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (19, N'Sean Miller', 4, 16)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (20, N'Sally Ryan', 4, 17)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (21, N'Han Solo Older', 5, 1)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (22, N'Luke Skywalker Older', 5, 6)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (23, N'Princess Leia', 5, 7)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (24, N'Kylo Ren', 5, 18)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (25, N'Rey', 5, 19)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (26, N'Finn', 5, 20)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (27, N'Poe Dameron', 5, 21)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (28, N'Vincent Vega', 6, 22)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (29, N'Pumpkin', 6, 23)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (30, N'Honey Bunny', 6, 24)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (31, N'Jules Winnfield', 6, 25)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (32, N'Marvin', 6, 26)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (33, N'The Bride', 7, 27)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (34, N'O-Ren Ishii', 7, 28)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (35, N'Vernita Green', 7, 29)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (36, N'Elle Driver', 7, 30)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (37, N'Bill', 7, 31)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (38, N'Mr White -Larry Dimmick', 8, 32)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (39, N'Mr Orange -Freddy Newanddyke', 8, 23)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (40, N'Mr Blonde -Vic Vega', 8, 33)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (41, N'Mr Brown', 8, 34)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (42, N'Mr Pink', 8, 35)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (43, N'Ordell Robbie', 9, 25)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (44, N'Jackie Brown', 9, 36)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (45, N'Max Cherry', 9, 37)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (46, N'Melanie Ralston', 9, 38)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (47, N'Ray Nicolette', 9, 39)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (48, N'Cobb', 10, 40)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (49, N'Arthur', 10, 41)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (50, N'Ariadne', 10, 42)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (51, N'Eames', 10, 43)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (52, N'Saito', 10, 44)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (53, N'Jack Dawson', 11, 40)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (54, N'Rose Bukater', 11, 45)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (55, N'Cal Hockley', 11, 46)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (56, N'Molly Brown', 11, 47)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (57, N'Ruth Bukater', 11, 48)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (58, N'Frodo Baggins fr', 12, 49)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (59, N'Sam fr', 12, 50)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (60, N'Legolas fr', 12, 51)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (61, N'Pippin fr', 12, 52)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (62, N'Bilbo fr', 12, 53)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (63, N'Frodo Baggins rk', 13, 49)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (64, N'Sam rk', 13, 50)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (65, N'Legolas rk', 13, 51)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (66, N'Pippin rk', 13, 52)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (67, N'Bilbo rk', 13, 53)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (68, N'Frodo Baggins 2t', 14, 49)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (69, N'Sam 2t', 14, 50)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (70, N'Legolas 2t', 14, 51)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (71, N'Pippin 2t', 14, 52)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (72, N'Bilbo 2t', 14, 53)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (73, N'Joker', 15, 54)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (74, N'Animal Mother', 15, 55)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (75, N'Private Pyle', 15, 56)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (76, N'Eightball', 15, 57)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (77, N'Private Cowboy', 15, 58)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (78, N'Batman bb', 16, 59)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (79, N'Alfred bb', 16, 60)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (80, N'Ducard bb', 16, 61)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (81, N'Rachel bb', 16, 62)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (82, N'Gordon bb', 16, 63)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (83, N'Batman dk', 17, 59)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (84, N'Joker dk', 17, 64)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (85, N'Alfred dk', 17, 60)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (86, N'Rachel dk', 17, 62)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (87, N'Gordon dk', 17, 63)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (88, N'Batman dkr', 18, 59)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (89, N'Bane dkr', 18, 43)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (90, N'Gordon dkr', 18, 63)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (91, N'Rachel dkr', 18, 62)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (92, N'Alfred dkr', 18, 60)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (93, N'Marty', 19, 65)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (94, N'Doc Brown', 19, 66)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (95, N'Lorraine', 19, 67)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (96, N'George', 19, 68)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (97, N'Biff', 19, 69)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (98, N'Harry Potter SS', 20, 70)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (99, N'Hermione Granger SS', 20, 71)
GO
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (100, N'Ron Weasley SS', 20, 72)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (101, N'Rubeus Hagrid SS', 20, 73)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (102, N'Albus Dumbledore SS', 20, 74)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (103, N'Severus Snape SS', 20, 75)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (104, N'Harry Potter CS', 21, 70)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (105, N'Hermione Granger CS', 21, 71)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (106, N'Ron Weasley CS', 21, 72)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (107, N'Rubeus Hagrid CS', 21, 73)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (108, N'Albus Dumbledore CS', 21, 74)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (109, N'Severus Snape CS', 21, 75)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (110, N'Harry Potter PA', 22, 70)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (111, N'Hermione Granger PA', 22, 71)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (112, N'Ron Weasley PA', 22, 72)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (113, N'Rubeus Hagrid PA', 22, 73)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (114, N'Albus Dumbledore PA', 22, 76)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (115, N'Severus Snape PA', 22, 75)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (116, N'Harry Potter GF', 23, 70)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (117, N'Hermione Granger GF', 23, 71)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (118, N'Ron Weasley GF', 23, 72)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (119, N'Rubeus Hagrid GF', 23, 73)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (120, N'Albus Dumbledore GF', 23, 76)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (121, N'Severus Snape GF', 23, 75)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (122, N'Harry Potter OP', 24, 70)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (123, N'Hermione Granger OP', 24, 71)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (124, N'Ron Weasley OP', 24, 72)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (125, N'Rubeus Hagrid OP', 24, 73)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (126, N'Albus Dumbledore OP', 24, 76)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (127, N'Severus Snape OP', 24, 75)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (128, N'Harry Potter HP', 25, 70)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (129, N'Hermione Granger HP', 25, 71)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (130, N'Ron Weasley HP', 25, 72)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (131, N'Rubeus Hagrid HP', 25, 73)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (132, N'Albus Dumbledore HP', 25, 76)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (133, N'Severus Snape HP', 25, 75)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (134, N'Harry Potter DH1', 26, 70)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (135, N'Hermione Granger DH1', 26, 71)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (136, N'Ron Weasley DH1', 26, 72)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (137, N'Rubeus Hagrid DH1', 26, 73)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (138, N'Albus Dumbledore DH1', 26, 76)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (139, N'Severus Snape DH1', 26, 75)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (140, N'Harry Potter DH2', 27, 70)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (141, N'Hermione Granger DH2', 27, 71)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (142, N'Ron Weasley DH2', 27, 72)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (143, N'Rubeus Hagrid DH2', 27, 73)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (144, N'Albus Dumbledore DH2', 27, 76)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (145, N'Severus Snape DH2', 27, 75)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (146, N'Newt', 28, 77)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (147, N'Tina', 28, 78)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (148, N'Credence Barebone', 28, 79)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (149, N'Graves', 28, 80)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (150, N'Jacob Kowalski', 28, 81)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (151, N'Queenie', 28, 82)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (152, N'Grindelwald', 28, 83)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (153, N'Aurora Lane', 29, 84)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (154, N'Jim Preston', 29, 85)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (155, N'Arthur P', 29, 86)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (156, N'Gus Mancuso', 29, 87)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (157, N'Mae', 30, 71)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (158, N'Bailey', 30, 88)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (159, N'Annie', 30, 89)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (160, N'Bonnie', 30, 90)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (161, N'Vinnie', 30, 91)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (162, N'Mercer', 30, 92)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (163, N'Neo', 31, 93)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (164, N'Morpheus', 31, 87)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (165, N'Trinity', 31, 94)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (166, N'Agent Smith', 31, 95)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (167, N'Oracle', 31, 96)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (168, N'Cypher', 31, 97)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (169, N'Neo R', 32, 93)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (170, N'Morpheus R', 32, 87)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (171, N'Trinity R', 32, 94)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (172, N'Agent Smith R', 32, 95)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (173, N'Oracle R', 32, 96)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (174, N'Neo MR', 33, 93)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (175, N'Morpheus MR', 33, 87)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (176, N'Agent Smith MR', 33, 95)
INSERT [dbo].[Role] ([RoleID], [Name], [FilmID], [ActorID]) VALUES (177, N'Oracle MR', 33, 98)
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[sysdiagrams] ON 

INSERT [dbo].[sysdiagrams] ([name], [principal_id], [diagram_id], [version], [definition]) VALUES (N'Diagram_Main', 1, 1, 1, 0xD0CF11E0A1B11AE1000000000000000000000000000000003E000300FEFF0900060000000000000000000000010000000100000000000000001000000200000001000000FEFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFF16000000FEFFFFFF0400000005000000060000001500000008000000090000000A0000000B0000000C0000000D0000000E0000000F0000001000000011000000120000001300000014000000FEFFFFFF22000000FEFFFFFF18000000190000001A0000001B0000001C0000001D0000001E0000001F0000002000000021000000FEFFFFFF23000000FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF52006F006F007400200045006E00740072007900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000016000500FFFFFFFFFFFFFFFF0200000000000000000000000000000000000000000000000000000000000000B03A249EA56ED30103000000C00C0000000000006600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004000201FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000000000000FA070000000000006F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040002010100000004000000FFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000070000001E1A000000000000010043006F006D0070004F0062006A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000201FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000200000005F000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000B0000000C0000000D0000000E0000000F000000100000001100000012000000130000001400000015000000160000001700000018000000190000001A0000001B0000001C0000001D0000001E0000001F000000FEFFFFFF21000000FEFFFFFFFEFFFFFF2400000025000000260000002700000028000000290000002A0000002B0000002C0000002D0000002E0000002F0000003000000031000000FEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000428000A0E100C05000080180000000F00FFFF18000000007D0000D9A400006E5D00009FB600006F7D0000DE805B10F195D011B0A000AA00BDCB5C0000080030000000000200000300000038002B00000009000000D9E6B0E91C81D011AD5100A0C90F5739F43B7F847F61C74385352986E1D552F8A0327DB2D86295428D98273C25A2DA2D00002C0043200000000000000000000053444DD2011FD1118E63006097D2DF4834C9D2777977D811907000065B840D9C00002C0043200000000000000000000051444DD2011FD1118E63006097D2DF4834C9D2777977D811907000065B840D9C180000000C0700000098010000003400A509000007000080010000009C020000008000000B0000805363684772696400000000000E1F00004163746F72202864626F290000003400A509000007000080020000009A020000008000000A0000805363684772696400DE3F00006E28000046696C6D202864626F29000000003800A50900000700008003000000A4020000008000000F0000805363684772696400A41F0000EA24000046696C6D4163746F72202864626F290000007800A5090000070000800400000052000000018000004E000080436F6E74726F6C005C1500009928000052656C6174696F6E736869702027464B5F4163746F725F46696C6D202864626F2927206265747765656E20274163746F72202864626F292720616E64202746696C6D4163746F72202864626F2927281C00002800B50100000700008005000000310000004D00000002800000436F6E74726F6C0048170000DF2A000000007800A5090000070000800600000062000000018000004D000080436F6E74726F6C00003500001F28000052656C6174696F6E736869702027464B5F46696C6D5F4163746F72202864626F2927206265747765656E202746696C6D202864626F292720616E64202746696C6D4163746F72202864626F292700281C00002800B50100000700008007000000310000004D00000002800000436F6E74726F6C006B3000001D32000000003C00A50900000700008008000000AA02000000800000120000805363684772696400DE3F0000AE15000046696C6D50726F6475636572202864626F29281C00007C00A50900000700008009000000520000000180000053000080436F6E74726F6C0069490000901C000052656C6174696F6E736869702027464B5F46696C6D5F50726F6475636572202864626F2927206265747765656E202746696C6D202864626F292720616E64202746696C6D50726F6475636572202864626F29270000002800B5010000070000800A000000310000005300000002800000436F6E74726F6C00AF4B00003023000000003400A5090000070000800B0000009C020000008000000B0000805363684772696400825F00003831000047656E7265202864626F296400007400A5090000070000800C000000520000000180000049000080436F6E74726F6C003A5500005134000052656C6174696F6E736869702027464B5F46696C6D5F47656E7265202864626F2927206265747765656E202747656E7265202864626F292720616E64202746696C6D202864626F292764626F00002800B5010000070000800D000000310000004D00000002800000436F6E74726F6C00F4560000E133000000003800A5090000070000800E000000A2020000008000000E0000805363684772696400DE3F00000000000050726F6475636572202864626F29000000008000A5090000070000800F000000520000000180000057000080436F6E74726F6C00694900006109000052656C6174696F6E736869702027464B5F50726F64756365725F46696C6D202864626F2927206265747765656E202750726F6475636572202864626F292720616E64202746696C6D50726F6475636572202864626F29270000002800B50100000700008010000000310000005300000002800000436F6E74726F6C00BE4000003710000000003400A509000007000080110000009E020000008000000C0000805363684772696400DE3F0000C24C0000526174696E67202864626F2900007400A5090000070000801200000052000000018000004B000080436F6E74726F6C0069490000AD40000052656C6174696F6E736869702027464B5F46696C6D5F526174696E67202864626F2927206265747765656E2027526174696E67202864626F292720616E64202746696C6D202864626F29272900002800B50100000700008013000000310000004F00000002800000436F6E74726F6C00AF4B00006947000000003400A509000007000080140000009A020000008000000A0000805363684772696400000000001C3E0000526F6C65202864626F29296400007400A50900000700008015000000520000000180000049000080436F6E74726F6C008B0900005B32000052656C6174696F6E736869702027464B5F526F6C655F4163746F72202864626F2927206265747765656E20274163746F72202864626F292720616E642027526F6C65202864626F2927007D0000002800B50100000700008016000000310000004D00000002800000436F6E74726F6C00730200000839000000007000A50900000700008017000000620000000180000047000080436F6E74726F6C005C150000E734000052656C6174696F6E736869702027464B5F526F6C655F46696C6D202864626F2927206265747765656E202746696C6D202864626F292720616E642027526F6C65202864626F29270000002800B50100000700008018000000310000004B00000002800000436F6E74726F6C00282C00001D430000000000000000214334120800000088160000041600007856341207000000140100004100630074006F00720020002800640062006F00290000005365727665722E4D616E6167656D656E742E44617461546F6F6C735D204D6963726F736F66742E53716C5365727665722E4D616E6167656D656E742E44617461546F6F6C732E4D657461446174612E4D657461446174614F626A65637453746F72653A3A53796E6368726F6E697A6528636C617373204D6963726F736F66742E53716C5365727665722E4D616E6167656D656E742E44617461546F6F6C732E4D657461446174612E4D65746144617461547970652C737472696E675B5D2C6F626A6563745B5D2C6F626A6563745B5D2C6F626A656374000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000F1190000000000002D010000090000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB070000550500000000000001000000881600000416000000000000070000000700000002000000020000001C010000F50A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F000000060000004100630074006F0072000000214334120800000088160000FA1A0000785634120700000014010000460069006C006D0020002800640062006F0029000000716C5365727665722E4D616E6167656D656E742E44617461546F6F6C735D204D6963726F736F66742E53716C5365727665722E4D616E6167656D656E742E44617461546F6F6C732E4D657461446174612E4D657461446174614F626A65637453746F72653A3A53796E6368726F6E697A6528636C617373204D6963726F736F66742E53716C5365727665722E4D616E6167656D656E742E44617461546F6F6C732E4D657461446174612E4D65746144617461547970652C737472696E675B5D2C6F626A6563745B5D2C6F626A6563745B5D2C6F626A656374000000000000000000000100000005000000540000002C0000002C0000002C000000340000000000000000000000222900007D1E0000000000002D0100000B0000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000FA1A000000000000090000000900000002000000020000001C010000F50A0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005200000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000005000000460069006C006D0000002143341208000000881600009D090000785634120700000014010000460069006C006D004100630074006F00720020002800640062006F0029000000F169056D04000000D0842803FFFFFFFFD88428033CEC7C19CC13008049000000C48DBB02D48CBB020000000000000000000000000C00056D6A71056D0400000049000000CC8DBB02E08CBB020000000000000000000000000C0000063213066DB279056D49000000BC8DBB02EC8CBB020000000000000000000000000800C76C3F0E00066F13066D49000000F88DBB02F88CBB020000000000000000000000000800C96C0010C76C400E000649000000D48DBB02048DBB0200000000000000000000000008006619990800800000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB070000550500000000000001000000881600009D09000000000000020000000200000002000000020000001C010000F50A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005C00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000A000000460069006C006D004100630074006F007200000002000B0088160000302A0000A41F0000302A00000000000002000000F0F0F0000000000000000000000000000000000001000000050000000000000048170000DF2A0000A80700005801000034000000010000020000A807000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D610D0046004B005F004100630074006F0072005F00460069006C006D0004000B00DE3F0000BC340000C2380000BC340000C23800009A2900002C3600009A2900000000000002000000F0F0F000000000000000000000000000000000000100000007000000000000006B3000001D320000A80700005801000032000000010000020000A807000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D610D0046004B005F00460069006C006D005F004100630074006F0072002143341208000000881600009D090000785634120700000014010000460069006C006D00500072006F006400750063006500720020002800640062006F00290000000000A00000004052F9007493EB140010EB14D5000006FB9CED14F6FAEE14040000004052F900FFFFFFFF381600064052F9008093EB140010EB14D6000006109DED14EEFAEE14030000004052F900DFEC5F19960700804052F9008C93EB140010EB14D7000006259DED144EFCEE14030000004052F900FFFFFFFFD88428034052F9003092EB140010EB14BF0000060000000000000000000000004052F900FFFFFFFF00000000CAEC4A193A12008000000000A0000000D08428035005C96C0010C76C150E0006A505000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB070000550500000000000001000000881600009D09000000000000020000000200000002000000020000001C010000F50A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006200000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000D000000460069006C006D00500072006F0064007500630065007200000002000B00004B00006E280000004B00004B1F00000000000002000000F0F0F00000000000000000000000000000000000010000000A00000000000000AF4B0000302300009309000058010000320000000100000200009309000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61100046004B005F00460069006C006D005F00500072006F00640075006300650072002143341208000000881600009D090000785634120700000014010000470065006E007200650020002800640062006F00290000005365727665722E4D616E6167656D656E742E44617461546F6F6C735D204D6963726F736F66742E53716C5365727665722E4D616E6167656D656E742E44617461546F6F6C732E4D657461446174612E4D657461446174614F626A65637453746F72653A3A53796E6368726F6E697A6528636C617373204D6963726F736F66742E53716C5365727665722E4D616E6167656D656E742E44617461546F6F6C732E4D657461446174612E4D65746144617461547970652C737472696E675B5D2C6F626A6563745B5D2C6F626A6563745B5D2C6F626A656374000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB070000550500000000000001000000881600009D09000000000000020000000200000002000000020000001C010000F50A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000006000000470065006E0072006500000002000B00825F0000E835000066560000E83500000000000002000000F0F0F00000000000000000000000000000000000010000000D00000000000000F4560000E13300000008000058010000320000000100000200000008000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D610D0046004B005F00460069006C006D005F00470065006E0072006500214334120800000088160000180C0000785634120700000014010000500072006F006400750063006500720020002800640062006F00290000002E4D616E6167656D656E742E44617461546F6F6C735D204D6963726F736F66742E53716C5365727665722E4D616E6167656D656E742E44617461546F6F6C732E4D657461446174612E4D657461446174614F626A65637453746F72653A3A53796E6368726F6E697A6528636C617373204D6963726F736F66742E53716C5365727665722E4D616E6167656D656E742E44617461546F6F6C732E4D657461446174612E4D65746144617461547970652C737472696E675B5D2C6F626A6563745B5D2C6F626A6563745B5D2C6F626A656374000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000180C000000000000030000000300000002000000020000001C010000F50A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000009000000500072006F0064007500630065007200000002000B00004B0000180C0000004B0000AE1500000000000002000000F0F0F00000000000000000000000000000000000010000001000000000000000BE400000371000009309000058010000320000000100000200009309000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61100046004B005F00500072006F00640075006300650072005F00460069006C006D002143341208000000881600009D09000078563412070000001401000052006100740069006E00670020002800640062006F0029000000727665722E4D616E6167656D656E742E44617461546F6F6C735D204D6963726F736F66742E53716C5365727665722E4D616E6167656D656E742E44617461546F6F6C732E4D657461446174612E4D657461446174614F626A65637453746F72653A3A53796E6368726F6E697A6528636C617373204D6963726F736F66742E53716C5365727665722E4D616E6167656D656E742E44617461546F6F6C732E4D657461446174612E4D65746144617461547970652C737472696E675B5D2C6F626A6563745B5D2C6F626A6563745B5D2C6F626A656374000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB070000550500000000000001000000881600009D09000000000000020000000200000002000000020000001C010000F50A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005600000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000700000052006100740069006E006700000002000B00004B0000C24C0000004B0000684300000000000002000000F0F0F00000000000000000000000000000000000010000001300000000000000AF4B0000694700003808000058010000320000000100000200003808000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D610E0046004B005F00460069006C006D005F0052006100740069006E006700214334120800000088160000930E000078563412070000001401000052006F006C00650020002800640062006F0029000000730020004D006900630072006F0073006F00660074002E00530071006C005300650072007600650072002E004D0061006E006100670065006D0065006E0074002E0044006100740061002E00440061007400610052006500610064006500720020002000280063006C006100730073002000530079007300740065006D002E0053007400720069006E0067002C0069006E007400330032002C0063006C0061007300730020004D006900630072006F0073006F00660074002E00530071006C005300650072007600650072002E004D0061006E0061006700000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000930E000000000000040000000400000002000000020000001C010000F50A0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005200000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000500000052006F006C006500000002000B00220B000012350000220B00001C3E00000000000002000000F0F0F0000000000000000000000000000000000001000000160000000000000073020000083900000008000058010000340000000100000200000008000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D610D0046004B005F0052006F006C0065005F004100630074006F00720004000B00DE3F00007E360000C23800007E360000C23800002445000088160000244500000000000002000000F0F0F00000000000000000000000000000000000010000001800000000000000282C00001D4300001907000058010000320000000100000200001907000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D610C0046004B005F0052006F006C0065005F00460069006C006D0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100FEFF030A0000FFFFFFFF00000000000000000000000000000000170000004D6963726F736F66742044445320466F726D20322E300010000000456D626564646564204F626A6563740000000000F439B271000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B0000004E61BC00000000000000000000000000000000000000000000000000000000000000000000000000000000000000DBE6B0E91C81D011AD5100A0C90F57390000020070DA199EA56ED301020200001048450000000000000000000000000000000000DA0100004400610074006100200053006F0075007200630065003D0065006300730033002E00640061007400610062006100730065002E00770069006E0064006F00770073002E006E00650074003B0049006E0069007400690061006C00200043006100740061006C006F0067003D0045004300530033003B005000650072007300690073007400200053006500630075007200690074007900200049006E0066006F003D0054007200750065003B0055007300650072002000490044003D00450043005300410064006D0069006E003B004D0075006C007400690070006C00650041006300740069007600650052006500730075006C00740053006500740073003D00460061006C0073000300440064007300530074007200650061006D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000160002000300000006000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000017000000261500000000000053006300680065006D00610020005500440056002000440065006600610075006C0074000000000000000000000000000000000000000000000000000000000026000200FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000220000001600000000000000440053005200450046002D0053004300480045004D0041002D0043004F004E00540045004E0054005300000000000000000000000000000000000000000000002C0002010500000007000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000023000000B60300000000000053006300680065006D00610020005500440056002000440065006600610075006C007400200050006F007300740020005600360000000000000000000000000036000200FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000003200000012000000000000000C00000000000000000000000100260000007300630068005F006C006100620065006C0073005F00760069007300690062006C0065000000010000000B0000001E000000000000000000000000000000000000006400000000000000000000000000000000000000000000000000010000000100000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000020000000200000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000030000000300000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000400000004000000000000002C0000000100000001000000640062006F00000046004B005F004100630074006F0072005F00460069006C006D0000000000000000000000C402000000000500000005000000040000000800000001132D0CB8132D0C0000000000000000AD0F00000100000600000006000000000000002C0000000100000001000000640062006F00000046004B005F00460069006C006D005F004100630074006F00720000000000000000000000C40200000000070000000700000006000000080000000172211C4872211C0000000000000000AD0F0000010000080000000800000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000090000000900000000000000320000000100000001000000640062006F00000046004B005F00460069006C006D005F00500072006F006400750063006500720000000000000000000000C402000000000A0000000A000000090000000800000001000F0CC8000F0C0000000000000000AD0F00000100000B0000000B00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000C0000000C000000000000002C0000000116C37601000000640062006F00000046004B005F00460069006C006D005F00470065006E007200650000000000000000000000C402000000000D0000000D0000000C0000000800000001040F0C88040F0C0000000000000000AD0F00000100000E0000000E00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000F0000000F000000000000003200000001006E0001000000640062006F00000046004B005F00500072006F00640075006300650072005F00460069006C006D0000000000000000000000C4020000000010000000100000000F0000000800000001FB271C58FB271C0000000000000000AD0F0000010000110000001100000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001200000012000000000000002E0000000100803F01000000640062006F00000046004B005F00460069006C006D005F0052006100740069006E00670000000000000000000000C402000000001300000013000000120000000800000001FF720CA0FF720C0000000000000000AD0F0000010000140000001400000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001500000015000000000000002C0000000100803F01000000640062006F00000046004B005F0052006F006C0065005F004100630074006F00720000000000000000000000C402000000001600000016000000150000000800000001F8720CE0F8720C0000000000000000AD0F00000100001700000017000000000000002A000000011FD81201000000640062006F00000046004B005F0052006F006C0065005F00460069006C006D0000000000000000000000C402000000001800000018000000170000000800000001FC720CA0FC720C0000000000000000AD0F00000100002800000015000000010000001400000025000000240000000400000001000000030000006F0000005A0000001700000002000000140000007800000061000000090000000200000008000000240000002500000006000000020000000300000072000000590000000C0000000B0000000200000058000000770000000F0000000E0000000800000025000000240000001200000011000000020000002400000025000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000065003B0054007200750073007400530065007200760065007200430065007200740069006600690063006100740065003D0054007200750065003B005000610063006B00650074002000530069007A0065003D0034003000390036003B004100700070006C00690063006100740069006F006E0020004E0061006D0065003D0022004D006900630072006F0073006F00660074002000530051004C00200053006500720076006500720020004D0061006E006100670065006D0065006E0074002000530074007500640069006F0022000000008005001A0000004400690061006700720061006D005F004D00610069006E000000000226000C0000004100630074006F007200000008000000640062006F000000000226000A000000460069006C006D00000008000000640062006F0000000002260014000000460069006C006D004100630074006F007200000008000000640062006F000000000226001A000000460069006C006D00500072006F0064007500630065007200000008000000640062006F000000000226000C000000470065006E0072006500000008000000640062006F0000000002260012000000500072006F0064007500630065007200000008000000640062006F000000000226000E00000052006100740069006E006700000008000000640062006F000000000224000A00000052006F006C006500000008000000640062006F00000001000000D68509B3BB6BF2459AB8371664F0327008004E0000007B00310036003300340043004400440037002D0030003800380038002D0034003200450033002D0039004600410032002D004200360044003300320035003600330042003900310044007D00000000000000000000000000010003000000000000000C0000000B00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000062885214)
SET IDENTITY_INSERT [dbo].[sysdiagrams] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_principal_name]    Script Date: 12/6/2017 1:00:06 PM ******/
ALTER TABLE [dbo].[sysdiagrams] ADD  CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
ALTER TABLE [dbo].[Film]  WITH CHECK ADD  CONSTRAINT [FK_Film_Genre] FOREIGN KEY([GenreID])
REFERENCES [dbo].[Genre] ([GenreID])
GO
ALTER TABLE [dbo].[Film] CHECK CONSTRAINT [FK_Film_Genre]
GO
ALTER TABLE [dbo].[Film]  WITH CHECK ADD  CONSTRAINT [FK_Film_Rating] FOREIGN KEY([RatingID])
REFERENCES [dbo].[Rating] ([RatingID])
GO
ALTER TABLE [dbo].[Film] CHECK CONSTRAINT [FK_Film_Rating]
GO
ALTER TABLE [dbo].[FilmActor]  WITH CHECK ADD  CONSTRAINT [FK_Actor_Film] FOREIGN KEY([ActorID])
REFERENCES [dbo].[Actor] ([ActorID])
GO
ALTER TABLE [dbo].[FilmActor] CHECK CONSTRAINT [FK_Actor_Film]
GO
ALTER TABLE [dbo].[FilmActor]  WITH CHECK ADD  CONSTRAINT [FK_Film_Actor] FOREIGN KEY([FilmID])
REFERENCES [dbo].[Film] ([FilmID])
GO
ALTER TABLE [dbo].[FilmActor] CHECK CONSTRAINT [FK_Film_Actor]
GO
ALTER TABLE [dbo].[FilmProducer]  WITH CHECK ADD  CONSTRAINT [FK_Film_Producer] FOREIGN KEY([FilmID])
REFERENCES [dbo].[Film] ([FilmID])
GO
ALTER TABLE [dbo].[FilmProducer] CHECK CONSTRAINT [FK_Film_Producer]
GO
ALTER TABLE [dbo].[FilmProducer]  WITH CHECK ADD  CONSTRAINT [FK_Producer_Film] FOREIGN KEY([ProducerID])
REFERENCES [dbo].[Producer] ([ProducerID])
GO
ALTER TABLE [dbo].[FilmProducer] CHECK CONSTRAINT [FK_Producer_Film]
GO
ALTER TABLE [dbo].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_Actor] FOREIGN KEY([ActorID])
REFERENCES [dbo].[Actor] ([ActorID])
GO
ALTER TABLE [dbo].[Role] CHECK CONSTRAINT [FK_Role_Actor]
GO
ALTER TABLE [dbo].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_Film] FOREIGN KEY([FilmID])
REFERENCES [dbo].[Film] ([FilmID])
GO
ALTER TABLE [dbo].[Role] CHECK CONSTRAINT [FK_Role_Film]
GO
/****** Object:  StoredProcedure [dbo].[AddNewMovie]    Script Date: 12/6/2017 1:00:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[AddNewMovie]  
   @ProducerFirstName varchar (50)=Null,
   @ProducerLastName varchar (50)=Null,
   @FilmName varchar (50)=Null,
   @FilmYear date=Null,
   @FilmReleased date=Null,
   @FilmRuntime varchar(50)=Null,
   @FilmimdbID varchar (50)=Null,
   @FilmPoster varchar (200)=Null,
   @GenreName varchar (50)=Null,
   @RatingName varchar(50)=Null,
   @ActorFirstName varchar(50)=Null,
   @ActorLastName varchar(50)=Null,
   @ActorBirthday date=Null,
   @ActorBirthCity varchar(50)=Null,
   @ActorBirthState varchar(50)=Null,
   @ActorBirthCountry varchar(50)=Null,
   @RoleName varchar(50)=Null    
as  
begin 
Declare @RatingID int
Declare @GenreID int
Declare @FilmID int
Declare @ProducerID int
Declare @ActorID int
Declare @RoleID int




Begin
Select @FilmID = FilmID from Film where Name = @FilmName
Select @GenreID = GenreID from Genre where Name = @GenreName
Select @RatingID = RatingID from Rating where Name = @RatingName
Select @ActorID = ActorID from Actor where (FirstName=@ActorFirstName) and (LastName=@ActorLastName)
Select @ProducerID = ProducerID from Producer where (FirstName=@ProducerFirstName) and (LastName=@ProducerLastName)
Select @RoleID = RoleID from Role where Name = @RoleName
end

If (@ProducerID is null)
begin
Insert into Producer(FirstName,LastName) values(@ProducerFirstName, @ProducerLastName) 
Select @ProducerID = SCOPE_IDENTITY()
end

If (@ActorID is null)
begin
Insert into Actor(FirstName,LastName,Birthday,BirthCity,BirthState,BirthCountry) values(@ActorFirstName, @ActorLastName,@ActorBirthday,@ActorBirthCity,@ActorBirthState,@ActorBirthCountry) 
Select @ActorID = SCOPE_IDENTITY()
end

If (@GenreID is null)
Begin
Insert into Genre values(@GenreName)
Select @GenreID = SCOPE_IDENTITY()
End

If (@RatingID is null)
Begin
Insert into Rating values(@RatingName)
Select @RatingID = SCOPE_IDENTITY()
End

If (@FilmID is null)
Begin
Insert into Film (Name,RatingID,GenreID, Year, Released, Runtime,imdbID,Poster) values(@FilmName,@RatingID, @GenreID, @FilmYear,@FilmReleased,@FilmRuntime,@FilmimdbID,@FilmPoster)
Select @FilmID = SCOPE_IDENTITY()
End

If (@RoleID is null)
Begin
Insert into Role (Name,FilmID,ActorID) values(@RoleName,@FilmID, @ActorID)
Select @RoleID = SCOPE_IDENTITY()
End

begin 
insert into FilmProducer (FilmID,ProducerID) values (@FilmID,@ProducerID)
end

begin 
insert into FilmActor (FilmID,ActorID) values (@FilmID,@ActorID)
end
End

GO
/****** Object:  StoredProcedure [dbo].[ClearEntireDB]    Script Date: 12/6/2017 1:00:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create procedure [dbo].[ClearEntireDB]  

as   
begin  
delete from Genre
delete from Rating
delete from Actor

delete from FilmActor
delete from FilmProducer

delete from Role
delete from film
End
begin  
delete from Genre
delete from Rating
delete from Actor

delete from FilmActor
delete from FilmProducer

delete from Role
delete from film
End


GO
/****** Object:  StoredProcedure [dbo].[DeleteMovie]    Script Date: 12/6/2017 1:00:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[DeleteMovie]  
(  
   @FilmID int
)  
as   
begin 
	Delete from Role where (FilmId=@FilmId)
	Delete from FilmActor where (FilmId=@FilmId)
	Delete from FilmProducer where (FilmId=@FilmId)  
	Delete from Film where (FilmID=@FilmID) 
End



GO
/****** Object:  StoredProcedure [dbo].[GetActorActionCalifornia]    Script Date: 12/6/2017 1:00:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[GetActorActionCalifornia]  

AS
Begin
select a.BirthState, a.FirstName, a.LastName, g.Name, f.Poster
From Actor as a
left join Role as r on a.ActorID = r.ActorID
left join Film as f on f.FilmID = r.FilmID
left join Genre as g on g.GenreID = f.GenreID
where a.BirthState = 'California' and g.Name = 'Action'
order by a.LastName asc
End


GO
/****** Object:  StoredProcedure [dbo].[GetActorMovies]    Script Date: 12/6/2017 1:00:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[GetActorMovies] 
@ActorID int=Null

as 
begin  
Select f.Poster as [FilmPoster], f.Name as [FilmName],a.FirstName as [ActorFirstName],
a.LastName as [ActorLastName], a.ActorID
FROM Actor as a
Left JOIN Role as r on r.ActorID =a.ActorID
Left JOIN Film as f on f.FilmID =r.FilmID
group by f.Name,a.FirstName,a.LastName, f.Poster,a.ActorID
having a.ActorID=@ActorID  OR ISNULL(@ActorID, '') = ''
End






GO
/****** Object:  StoredProcedure [dbo].[GetActorNotUSARatingOver75]    Script Date: 12/6/2017 1:00:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[GetActorNotUSARatingOver75]  

AS
BEGIN
select a.BirthCountry, a.FirstName, a.LastName, s.Name, f.Poster
From Actor as a
left join Role as r on a.ActorID = r.ActorID
left join Film as f on f.FilmID = r.FilmID
left join Rating as s on s.RatingID = f.RatingID
where a.BirthCountry != 'USA' and s.Name > '75'
order by a.BirthCountry asc
End


GO
/****** Object:  StoredProcedure [dbo].[GetActors]    Script Date: 12/6/2017 1:00:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[GetActors]  

AS
Begin
select  a.ActorID, a.FirstName as [ActorFirstName],
a.LastName as [ActorLastName]
from Actor as a
order by a.LastName asc
End



GO
/****** Object:  StoredProcedure [dbo].[GetActorsByAge]    Script Date: 12/6/2017 1:00:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetActorsByAge]  

@age int=NULL,
@type varchar(10)='None'

AS
Begin
if(@type = '=') BEGIN
	SELECT *, (YEAR(GETDATE()) - YEAR(Birthday)) AS ActorAge FROM Actor
	WHERE (YEAR(GETDATE()) - YEAR(Birthday)) = @Age
	ORDER BY ActorAge DESC;
END ELSE IF(@type = '>') BEGIN
	SELECT *, (YEAR(GETDATE()) - YEAR(Birthday)) AS ActorAge FROM Actor
	WHERE (YEAR(GETDATE()) - YEAR(Birthday)) > @Age
	ORDER BY ActorAge DESC;
END ELSE IF(@TYPE = '<') BEGIN
	SELECT *, (YEAR(GETDATE()) - YEAR(Birthday)) AS ActorAge FROM Actor
	WHERE (YEAR(GETDATE()) - YEAR(Birthday)) < @Age
	ORDER BY ActorAge DESC;
END ELSE BEGIN
	SELECT *, (YEAR(GETDATE()) - YEAR(Birthday)) AS ActorAge FROM Actor
	ORDER BY ActorAge DESC;
END
End


GO
/****** Object:  StoredProcedure [dbo].[GetActorsMovieCount]    Script Date: 12/6/2017 1:00:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetActorsMovieCount]  

AS
Begin
SELECT Actor.ActorID, Actor.FirstName, Actor.LastName, COUNT(Film.FilmID) as [Number of Films] FROM Film
INNER JOIN FilmActor on FilmActor.FilmID=Film.FilmID
INNER JOIN Actor on Actor.ActorID=FilmActor.ActorID
GROUP BY Actor.ActorID, Actor.FirstName, Actor.LastName
ORDER BY [Number of Films] DESC
End

GO
/****** Object:  StoredProcedure [dbo].[GetActorsStateCount]    Script Date: 12/6/2017 1:00:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[GetActorsStateCount]  

AS
Begin
select BirthState,
count(BirthState) as [Actors per State] from Actor 
Group By BirthState,BirthCountry
having BirthCountry ='USA'
order by [Actors per State] desc
End


GO
/****** Object:  StoredProcedure [dbo].[GetMovieDetails]    Script Date: 12/6/2017 1:00:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[GetMovieDetails]  
as 

begin
Select f.Name as [FilmName], g.Name as [GenreName], r.Name as [RatingName], f.FilmID, f.GenreID, f.RatingID, f.Year as [FilmYear],f.Released as[FilmReleased],f.Runtime as [FilmRuntime],
f.imdbID as [FilmimdbID], f.Poster as [FilmPoster],fp.ProducerID,p.FirstName as[ProducerFirstName], p.LastName as [ProducerLastName], p.ProducerID, a.FirstName as [ActorFirstName],
a.LastName as [ActorLastName], a.Birthday as[ActorBirthday], a.Birthcity as [ActorBirthCity],a.BirthState as [ActorBirthState], a.BirthCountry as  [ActorBirthcountry],
ra.Name as [RoleName]
FROM Film as f
Left Outer JOIN Genre as g on f.GenreID=g.GenreID
Left Outer JOIN Rating as r on f.RatingID=r.RatingID
Left Outer JOIN FilmProducer as fp on f.FilmID=fp.FilmID
Left Outer Join Producer as p on fp.ProducerId=p.ProducerID
Left Outer Join Role as ra on ra.FilmID=f.FilmID
Left Outer join Actor as a on a.ActorID=ra.ActorID


end

GO
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 12/6/2017 1:00:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_alterdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 12/6/2017 1:00:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_creatediagram]
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 12/6/2017 1:00:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_dropdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 12/6/2017 1:00:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagramdefinition]
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 12/6/2017 1:00:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagrams]
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 12/6/2017 1:00:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_renamediagram]
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 12/6/2017 1:00:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_upgraddiagrams]
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
	
GO
/****** Object:  StoredProcedure [dbo].[UpdateMovieDetails]    Script Date: 12/6/2017 1:00:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[UpdateMovieDetails]  
(  
   @FilmID int,
   @ProducerFirstName varchar (50),
   @ProducerLastName varchar (50),
   @FilmName varchar (50),
   @FilmYear date,
   @FilmReleased date,
   @FilmRuntime varchar(50),
   @FilmimdbID varchar (50),
   @FilmPoster varchar (200),
   @GenreName varchar (50),
   @RatingName varchar(50),
   @ActorFirstName varchar(50),
   @ActorLastName varchar(50),
   @ActorBirthday date=Null,
   @ActorBirthCity varchar(50)=Null,
   @ActorBirthState varchar(50)=Null,
   @ActorBirthCountry varchar(50)=Null,
   @RoleName varchar(50)        
)  
as  
begin 
Declare @RatingID int
Declare @GenreID int
Declare @ProducerID int
Declare @ActorID int
Declare @RoleID int

Begin
Select @FilmID = FilmID from Film where Name = @FilmName
Select @GenreID = GenreID from Genre where Name = @GenreName
Select @RatingID = RatingID from Rating where Name = @RatingName
Select @ActorID = ActorID from Actor where (FirstName=@ActorFirstName) and (LastName=@ActorLastName)
Select @ProducerID = ProducerID from Producer where (FirstName=@ProducerFirstName) and (LastName=@ProducerLastName)
Select @RoleID = RoleID from Role where Name = @RoleName
end

If (@ProducerID is null)
begin
Insert into Producer(FirstName,LastName) values(@ProducerFirstName, @ProducerLastName) 
Select @ProducerID = SCOPE_IDENTITY()
end

If (@ActorID is null)
begin
Insert into Actor(FirstName,LastName,Birthday,BirthCity,BirthState,BirthCountry) values(@ActorFirstName, @ActorLastName,@ActorBirthday,@ActorBirthCity,@ActorBirthState,@ActorBirthCountry) 
Select @ActorID = SCOPE_IDENTITY()
end

If (@GenreID is null)
Begin
Insert into Genre values(@GenreName)
Select @GenreID = SCOPE_IDENTITY()
End

If (@RatingID is null)
Begin
Insert into Rating values(@RatingName)
Select @RatingID = SCOPE_IDENTITY()
End

If (@FilmID is null)
Begin
Insert into Film (Name,RatingID,GenreID, Year, Released, Runtime,imdbID,Poster) values(@FilmName,@RatingID, @GenreID, @FilmYear,@FilmReleased,@FilmRuntime,@FilmimdbID,@FilmPoster)
Select @FilmID = SCOPE_IDENTITY()
End

If (@RoleID is null)
Begin
Insert into Role (Name,FilmID,ActorID) values(@RoleName,@FilmID, @ActorID)
Select @RoleID = SCOPE_IDENTITY()
End

Update Film   
	 set Name=@FilmName,  
	 GenreID=@GenreID,  
	 RatingID=@RatingID, 
	 Year=@FilmYear,
	 Released=@FilmReleased,
	 Runtime=@FilmRuntime,
	 imdbID=@FilmimdbID,
	 Poster=@FilmPoster
	where FilmID=@FilmID 
Update Producer
	set FirstName=@ProducerFirstName,
	LastName=@ProducerLastName
	where ProducerID=@ProducerID
Update Actor
	set FirstName=@ActorFirstName,
	LastName=@ActorLastName,
	Birthday=@ActorBirthday,
	BirthCity=@ActorBirthCity,
	BirthState=@ActorBirthState,
	BirthCountry=@ActorBirthCountry
	where ActorID=@ActorID
Update FilmProducer
	set ProducerID=@ProducerID
	where FilmID=@FilmID
begin 
insert into FilmActor (FilmID,ActorID) values (@FilmID,@ActorID)
end

    
End


GO
USE [master]
GO
ALTER DATABASE [ECS3] SET  READ_WRITE 
GO
