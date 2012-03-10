/****** Object:  Table [#__viewlevels]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__viewlevels]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__viewlevels](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](100) NOT NULL,
	[ordering] [int] NOT NULL,
	[rules] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_#__viewlevels_id] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF),
 CONSTRAINT [#__viewlevels$idx_assetgroup_title_lookup] UNIQUE NONCLUSTERED
(
	[title] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;


/****** Object:  Default [DF__#__viewl__title__01D345B0]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__viewl__title__01D345B0]') AND parent_object_id = OBJECT_ID(N'[#__viewlevels]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__viewl__title__01D345B0]') AND type = 'D')
BEGIN
ALTER TABLE [#__viewlevels] ADD  DEFAULT (N'') FOR [title]
END


End;

/****** Object:  Default [DF__#__viewl__order__02C769E9]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__viewl__order__02C769E9]') AND parent_object_id = OBJECT_ID(N'[#__viewlevels]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__viewl__order__02C769E9]') AND type = 'D')
BEGIN
ALTER TABLE [#__viewlevels] ADD  DEFAULT ((0)) FOR [ordering]
END


End;


SET IDENTITY_INSERT #__viewlevels  ON;

INSERT INTO #__viewlevels (id, title, ordering, rules)
SELECT 1, 'Public', 0, '[1]'
UNION ALL
SELECT 2, 'Registered', 1, '[6,2,8]'
UNION ALL
SELECT 3, 'Special', 2, '[6,3,8]';

SET IDENTITY_INSERT #__viewlevels  OFF;


/****** Object:  Table [#__users]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__users]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__users](
	[id] [int] IDENTITY(42,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[username] [nvarchar](150) NOT NULL,
	[email] [nvarchar](100) NOT NULL,
	[password] [nvarchar](100) NOT NULL,
	[usertype] [nvarchar](25) NOT NULL,
	[block] [smallint] NOT NULL,
	[sendEmail] [smallint] NULL,
	[registerDate] [datetime] NOT NULL,
	[lastvisitDate] [datetime] NOT NULL,
	[activation] [nvarchar](100) NOT NULL,
	[params] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_#__users_id] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__users]') AND name = N'email')
CREATE NONCLUSTERED INDEX [email] ON [#__users]
(
	[email] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__users]') AND name = N'idx_block')
CREATE NONCLUSTERED INDEX [idx_block] ON [#__users]
(
	[block] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__users]') AND name = N'idx_name')
CREATE NONCLUSTERED INDEX [idx_name] ON [#__users]
(
	[name] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__users]') AND name = N'username')
CREATE NONCLUSTERED INDEX [username] ON [#__users]
(
	[username] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__users]') AND name = N'usertype')
CREATE NONCLUSTERED INDEX [usertype] ON [#__users]
(
	[usertype] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

/****** Object:  Default [DF__#__users__name__7755B73D]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__users__name__7755B73D]') AND parent_object_id = OBJECT_ID(N'[#__users]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__users__name__7755B73D]') AND type = 'D')
BEGIN
ALTER TABLE [#__users] ADD  DEFAULT (N'') FOR [name]
END


End;

/****** Object:  Default [DF__#__users__usern__7849DB76]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__users__usern__7849DB76]') AND parent_object_id = OBJECT_ID(N'[#__users]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__users__usern__7849DB76]') AND type = 'D')
BEGIN
ALTER TABLE [#__users] ADD  DEFAULT (N'') FOR [username]
END


End;

/****** Object:  Default [DF__#__users__email__793DFFAF]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__users__email__793DFFAF]') AND parent_object_id = OBJECT_ID(N'[#__users]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__users__email__793DFFAF]') AND type = 'D')
BEGIN
ALTER TABLE [#__users] ADD  DEFAULT (N'') FOR [email]
END


End;

/****** Object:  Default [DF__#__users__passw__7A3223E8]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__users__passw__7A3223E8]') AND parent_object_id = OBJECT_ID(N'[#__users]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__users__passw__7A3223E8]') AND type = 'D')
BEGIN
ALTER TABLE [#__users] ADD  DEFAULT (N'') FOR [password]
END


End;

/****** Object:  Default [DF__#__users__usert__7B264821]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__users__usert__7B264821]') AND parent_object_id = OBJECT_ID(N'[#__users]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__users__usert__7B264821]') AND type = 'D')
BEGIN
ALTER TABLE [#__users] ADD  DEFAULT (N'') FOR [usertype]
END


End;

/****** Object:  Default [DF__#__users__block__7C1A6C5A]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__users__block__7C1A6C5A]') AND parent_object_id = OBJECT_ID(N'[#__users]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__users__block__7C1A6C5A]') AND type = 'D')
BEGIN
ALTER TABLE [#__users] ADD  DEFAULT ((0)) FOR [block]
END


End;

/****** Object:  Default [DF__#__users__sendE__7D0E9093]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__users__sendE__7D0E9093]') AND parent_object_id = OBJECT_ID(N'[#__users]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__users__sendE__7D0E9093]') AND type = 'D')
BEGIN
ALTER TABLE [#__users] ADD  DEFAULT ((0)) FOR [sendEmail]
END


End;

/****** Object:  Default [DF__#__users__regis__7E02B4CC]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__users__regis__7E02B4CC]') AND parent_object_id = OBJECT_ID(N'[#__users]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__users__regis__7E02B4CC]') AND type = 'D')
BEGIN
ALTER TABLE [#__users] ADD  DEFAULT ('1900-01-01 00:00:00') FOR [registerDate]
END


End;

/****** Object:  Default [DF__#__users__lastv__7EF6D905]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__users__lastv__7EF6D905]') AND parent_object_id = OBJECT_ID(N'[#__users]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__users__lastv__7EF6D905]') AND type = 'D')
BEGIN
ALTER TABLE [#__users] ADD  DEFAULT ('1900-01-01 00:00:00') FOR [lastvisitDate]
END


End;

/****** Object:  Default [DF__#__users__activ__7FEAFD3E]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__users__activ__7FEAFD3E]') AND parent_object_id = OBJECT_ID(N'[#__users]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__users__activ__7FEAFD3E]') AND type = 'D')
BEGIN
ALTER TABLE [#__users] ADD  DEFAULT (N'') FOR [activation]
END


End;


/****** Object:  Table [#__associations]    Script Date: 11/08/2010 18:41:22 ******/


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__associations]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__associations](
	[id] [nvarchar](50) NOT NULL,
	[context] [nvarchar](50) NOT NULL,
	[key] [nchar](32) NOT NULL,
 CONSTRAINT [PK_#__associations_context] PRIMARY KEY CLUSTERED
(
	[context] ASC,
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;


/****** Object:  Table [#__user_usergroup_map]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__user_usergroup_map]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__user_usergroup_map](
	[user_id] [bigint] NOT NULL,
	[group_id] [bigint] NOT NULL,
 CONSTRAINT [PK_#__user_usergroup_map_user_id] PRIMARY KEY CLUSTERED
(
	[user_id] ASC,
	[group_id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;

/****** Object:  Default [DF__#__user___user___6FB49575]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__user___user___6FB49575]') AND parent_object_id = OBJECT_ID(N'[#__user_usergroup_map]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__user___user___6FB49575]') AND type = 'D')
BEGIN
ALTER TABLE [#__user_usergroup_map] ADD  DEFAULT ((0)) FOR [user_id]
END


End;


IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__user___group__70A8B9AE]') AND parent_object_id = OBJECT_ID(N'[#__user_usergroup_map]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__user___group__70A8B9AE]') AND type = 'D')
BEGIN
ALTER TABLE [#__user_usergroup_map] ADD  DEFAULT ((0)) FOR [group_id]
END


End;


/****** Object:  Table [#__updates]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__updates]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__updates](
	[update_id] [int] IDENTITY(1,1) NOT NULL,
	[update_site_id] [int] NULL,
	[extension_id] [int] NULL,
	[cateryid] [int] NULL,
	[name] [nvarchar](100) NULL,
	[description] [nvarchar](max) NOT NULL,
	[element] [nvarchar](100) NULL,
	[type] [nvarchar](20) NULL,
	[folder] [nvarchar](20) NULL,
	[client_id] [smallint] NULL,
	[version] [nvarchar](10) NULL,
	[data] [nvarchar](max) NOT NULL,
	[detailsurl] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_#__updates_update_id] PRIMARY KEY CLUSTERED
(
	[update_id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;

/****** Object:  Default [DF__#__updat__updat__6442E2C9]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__updat__updat__6442E2C9]') AND parent_object_id = OBJECT_ID(N'[#__updates]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__updat__updat__6442E2C9]') AND type = 'D')
BEGIN
ALTER TABLE [#__updates] ADD  DEFAULT ((0)) FOR [update_site_id]
END


End;

/****** Object:  Default [DF__#__updat__exten__65370702]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__updat__exten__65370702]') AND parent_object_id = OBJECT_ID(N'[#__updates]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__updat__exten__65370702]') AND type = 'D')
BEGIN
ALTER TABLE [#__updates] ADD  DEFAULT ((0)) FOR [extension_id]
END


End;

/****** Object:  Default [DF__#__updat__categ__662B2B3B]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__updat__categ__662B2B3B]') AND parent_object_id = OBJECT_ID(N'[#__updates]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__updat__categ__662B2B3B]') AND type = 'D')
BEGIN
ALTER TABLE [#__updates] ADD  DEFAULT ((0)) FOR [cateryid]
END


End;

/****** Object:  Default [DF__#__update__name__671F4F74]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__update__name__671F4F74]') AND parent_object_id = OBJECT_ID(N'[#__updates]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__update__name__671F4F74]') AND type = 'D')
BEGIN
ALTER TABLE [#__updates] ADD  DEFAULT (N'') FOR [name]
END


End;

/****** Object:  Default [DF__#__updat__eleme__681373AD]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__updat__eleme__681373AD]') AND parent_object_id = OBJECT_ID(N'[#__updates]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__updat__eleme__681373AD]') AND type = 'D')
BEGIN
ALTER TABLE [#__updates] ADD  DEFAULT (N'') FOR [element]
END


End;

/****** Object:  Default [DF__#__update__type__690797E6]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__update__type__690797E6]') AND parent_object_id = OBJECT_ID(N'[#__updates]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__update__type__690797E6]') AND type = 'D')
BEGIN
ALTER TABLE [#__updates] ADD  DEFAULT (N'') FOR [type]
END


End;

/****** Object:  Default [DF__#__updat__folde__69FBBC1F]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__updat__folde__69FBBC1F]') AND parent_object_id = OBJECT_ID(N'[#__updates]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__updat__folde__69FBBC1F]') AND type = 'D')
BEGIN
ALTER TABLE [#__updates] ADD  DEFAULT (N'') FOR [folder]
END


End;

/****** Object:  Default [DF__#__updat__clien__6AEFE058]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__updat__clien__6AEFE058]') AND parent_object_id = OBJECT_ID(N'[#__updates]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__updat__clien__6AEFE058]') AND type = 'D')
BEGIN
ALTER TABLE [#__updates] ADD  DEFAULT ((0)) FOR [client_id]
END


End;

/****** Object:  Default [DF__#__updat__versi__6BE40491]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__updat__versi__6BE40491]') AND parent_object_id = OBJECT_ID(N'[#__updates]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__updat__versi__6BE40491]') AND type = 'D')
BEGIN
ALTER TABLE [#__updates] ADD  DEFAULT (N'') FOR [version]
END


End;


/****** Object:  Table [#__update_sites]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__update_sites]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__update_sites](
	[update_site_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NULL,
	[type] [nvarchar](20) NULL,
	[location] [nvarchar](max) NOT NULL,
	[enabled] [int] NULL,
	[last_check_timestamp] [int] DEFAULT '0',
 CONSTRAINT [PK_#__update_sites_update_site_id] PRIMARY KEY CLUSTERED
(
	[update_site_id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;

/****** Object:  Default [DF__#__update__name__5D95E53A]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__update__name__5D95E53A]') AND parent_object_id = OBJECT_ID(N'[#__update_sites]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__update__name__5D95E53A]') AND type = 'D')
BEGIN
ALTER TABLE [#__update_sites] ADD  DEFAULT (N'') FOR [name]
END


End;

/****** Object:  Default [DF__#__update__type__5E8A0973]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__update__type__5E8A0973]') AND parent_object_id = OBJECT_ID(N'[#__update_sites]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__update__type__5E8A0973]') AND type = 'D')
BEGIN
ALTER TABLE [#__update_sites] ADD  DEFAULT (N'') FOR [type]
END


End;
/****** Object:  Default [DF__#__updat__enabl__5F7E2DAC]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__updat__enabl__5F7E2DAC]') AND parent_object_id = OBJECT_ID(N'[#__update_sites]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__updat__enabl__5F7E2DAC]') AND type = 'D')
BEGIN
ALTER TABLE [#__update_sites] ADD  DEFAULT ((0)) FOR [enabled]
END


End;


SET IDENTITY_INSERT #__update_sites ON;

INSERT INTO #__update_sites (update_site_id, name , type, location, enabled, last_check_timestamp) VALUES
(1, 'Square One', 'collection', 'http://update.squareonecms.org/list.xml', 1, 0);

SET IDENTITY_INSERT #__update_sites OFF;


/****** Object:  Table [#__update_sites_extensions]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__update_sites_extensions]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__update_sites_extensions](
	[update_site_id] [int] NOT NULL,
	[extension_id] [int] NOT NULL,
 CONSTRAINT [PK_#__update_sites_extensions_update_site_id] PRIMARY KEY CLUSTERED
(
	[update_site_id] ASC,
	[extension_id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;

/****** Object:  Default [DF__#__updat__updat__6166761E]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__updat__updat__6166761E]') AND parent_object_id = OBJECT_ID(N'[#__update_sites_extensions]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__updat__updat__6166761E]') AND type = 'D')
BEGIN
ALTER TABLE [#__update_sites_extensions] ADD  DEFAULT ((0)) FOR [update_site_id]
END


End;

/****** Object:  Default [DF__#__updat__exten__625A9A57]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__updat__exten__625A9A57]') AND parent_object_id = OBJECT_ID(N'[#__update_sites_extensions]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__updat__exten__625A9A57]') AND type = 'D')
BEGIN
ALTER TABLE [#__update_sites_extensions] ADD  DEFAULT ((0)) FOR [extension_id]
END


End;

INSERT INTO #__update_sites_extensions (update_site_id, extension_id)
SELECT 1, 700


/****** Object:  Table [#__update_categories]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__update_categories]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__update_categories](
	[cateryid] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](20) NULL,
	[description] [nvarchar](max) NOT NULL,
	[parent] [int] NULL,
	[updatesite] [int] NULL,
 CONSTRAINT [PK_#__update_categories_cateryid] PRIMARY KEY CLUSTERED
(
	[cateryid] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;

/****** Object:  Default [DF__#__update__name__59C55456]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__update__name__59C55456]') AND parent_object_id = OBJECT_ID(N'[#__update_categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__update__name__59C55456]') AND type = 'D')
BEGIN
ALTER TABLE [#__update_categories] ADD  DEFAULT (N'') FOR [name]
END


End;

/****** Object:  Default [DF__#__updat__paren__5AB9788F]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__updat__paren__5AB9788F]') AND parent_object_id = OBJECT_ID(N'[#__update_categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__updat__paren__5AB9788F]') AND type = 'D')
BEGIN
ALTER TABLE [#__update_categories] ADD  DEFAULT ((0)) FOR [parent]
END


End;

/****** Object:  Default [DF__#__updat__updat__5BAD9CC8]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__updat__updat__5BAD9CC8]') AND parent_object_id = OBJECT_ID(N'[#__update_categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__updat__updat__5BAD9CC8]') AND type = 'D')
BEGIN
ALTER TABLE [#__update_categories] ADD  DEFAULT ((0)) FOR [updatesite]
END


End;


/****** Object:  Table [#__template_styles]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__template_styles]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__template_styles](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[template] [nvarchar](50) NOT NULL,
	[client_id] [tinyint] NOT NULL,
	[home] [nvarchar](7) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[params] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_#__template_styles_id] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__template_styles]') AND name = N'idx_home')
CREATE NONCLUSTERED INDEX [idx_home] ON [#__template_styles]
(
	[home] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__template_styles]') AND name = N'idx_template')
CREATE NONCLUSTERED INDEX [idx_template] ON [#__template_styles]
(
	[template] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);


/****** Object:  Default [DF__#__templ__templ__540C7B00]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__templ__templ__540C7B00]') AND parent_object_id = OBJECT_ID(N'[#__template_styles]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__templ__templ__540C7B00]') AND type = 'D')
BEGIN
ALTER TABLE [#__template_styles] ADD  DEFAULT (N'') FOR [template]
END


End;

/****** Object:  Default [DF__#__templ__clien__55009F39]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__templ__clien__55009F39]') AND parent_object_id = OBJECT_ID(N'[#__template_styles]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__templ__clien__55009F39]') AND type = 'D')
BEGIN
ALTER TABLE [#__template_styles] ADD  DEFAULT ((0)) FOR [client_id]
END


End;

/****** Object:  Default [DF__#__templa__home__55F4C372]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__templa__home__55F4C372]') AND parent_object_id = OBJECT_ID(N'[#__template_styles]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__templa__home__55F4C372]') AND type = 'D')
BEGIN
ALTER TABLE [#__template_styles] ADD  DEFAULT (('0')) FOR [home]
END


End;

/****** Object:  Default [DF__#__templ__title__56E8E7AB]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__templ__title__56E8E7AB]') AND parent_object_id = OBJECT_ID(N'[#__template_styles]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__templ__title__56E8E7AB]') AND type = 'D')
BEGIN
ALTER TABLE [#__template_styles] ADD  DEFAULT (N'') FOR [title]
END


End;

/****** Object:  Default [DF__#__templ__param__57DD0BE4]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__templ__param__57DD0BE4]') AND parent_object_id = OBJECT_ID(N'[#__template_styles]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__templ__param__57DD0BE4]') AND type = 'D')
BEGIN
ALTER TABLE [#__template_styles] ADD  DEFAULT (N'') FOR [params]
END


End;


SET IDENTITY_INSERT #__template_styles  ON;

INSERT INTO #__template_styles (id, template, client_id, home, title, params) VALUES (1, 'system', 1, 1, 'System - Default', '{"useRoundedCorners":"1","showSiteName":"0"}');
INSERT INTO #__template_styles (id, template, client_id, home, title, params) VALUES (2, 'system', 0, 1, 'System - Default', '');
SET IDENTITY_INSERT #__template_styles  OFF;


/****** Object:  Table [#__session]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__session]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__session](
	[session_id] [nvarchar](32) NOT NULL,
	[client_id] [tinyint] NOT NULL,
	[guest] [tinyint] NULL,
	[time] [nvarchar](14) NULL,
	[data] [nvarchar](max) NULL,
	[userid] [int] NULL,
	[username] [nvarchar](150) NULL,
	[usertype] [nvarchar](50) NULL,
 CONSTRAINT [PK_#__session_session_id] PRIMARY KEY CLUSTERED
(
	[session_id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__session]') AND name = N'time')
CREATE NONCLUSTERED INDEX [time] ON [#__session]
(
	[time] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__session]') AND name = N'userid')
CREATE NONCLUSTERED INDEX [userid] ON [#__session]
(
	[userid] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__session]') AND name = N'whosonline')
CREATE NONCLUSTERED INDEX [whosonline] ON [#__session]
(
	[guest] ASC,
	[usertype] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);


/****** Object:  Default [DF__#__sessi__sessi__4B7734FF]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__sessi__sessi__4B7734FF]') AND parent_object_id = OBJECT_ID(N'[#__session]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__sessi__sessi__4B7734FF]') AND type = 'D')
BEGIN
ALTER TABLE [#__session] ADD  DEFAULT (N'') FOR [session_id]
END


End;

/****** Object:  Default [DF__#__sessi__clien__4C6B5938]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__sessi__clien__4C6B5938]') AND parent_object_id = OBJECT_ID(N'[#__session]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__sessi__clien__4C6B5938]') AND type = 'D')
BEGIN
ALTER TABLE [#__session] ADD  DEFAULT ((0)) FOR [client_id]
END


End;

/****** Object:  Default [DF__#__sessi__guest__4D5F7D71]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__sessi__guest__4D5F7D71]') AND parent_object_id = OBJECT_ID(N'[#__session]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__sessi__guest__4D5F7D71]') AND type = 'D')
BEGIN
ALTER TABLE [#__session] ADD  DEFAULT ((1)) FOR [guest]
END


End;

/****** Object:  Default [DF__#__sessio__time__4E53A1AA]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__sessio__time__4E53A1AA]') AND parent_object_id = OBJECT_ID(N'[#__session]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__sessio__time__4E53A1AA]') AND type = 'D')
BEGIN
ALTER TABLE [#__session] ADD  DEFAULT (N'') FOR [time]
END


End;

/****** Object:  Default [DF__#__sessio__data__4F47C5E3]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__sessio__data__4F47C5E3]') AND parent_object_id = OBJECT_ID(N'[#__session]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__sessio__data__4F47C5E3]') AND type = 'D')
BEGIN
ALTER TABLE [#__session] ADD  DEFAULT (NULL) FOR [data]
END


End;

/****** Object:  Default [DF__#__sessi__useri__503BEA1C]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__sessi__useri__503BEA1C]') AND parent_object_id = OBJECT_ID(N'[#__session]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__sessi__useri__503BEA1C]') AND type = 'D')
BEGIN
ALTER TABLE [#__session] ADD  DEFAULT ((0)) FOR [userid]
END


End;

/****** Object:  Default [DF__#__sessi__usern__51300E55]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__sessi__usern__51300E55]') AND parent_object_id = OBJECT_ID(N'[#__session]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__sessi__usern__51300E55]') AND type = 'D')
BEGIN
ALTER TABLE [#__session] ADD  DEFAULT (N'') FOR [username]
END


End;

/****** Object:  Default [DF__#__sessi__usert__5224328E]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__sessi__usert__5224328E]') AND parent_object_id = OBJECT_ID(N'[#__session]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__sessi__usert__5224328E]') AND type = 'D')
BEGIN
ALTER TABLE [#__session] ADD  DEFAULT (N'') FOR [usertype]
END


End;


/****** Object:  Table [#__schemas]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__schemas]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__schemas](
	[extension_id] [int] NOT NULL,
	[version_id] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_#__schemas_extension_id] PRIMARY KEY CLUSTERED
(
	[extension_id] ASC,
	[version_id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;


/****** Object:  Table [#__overrider]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__overrider]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__overrider] (
  [id] [int] IDENTITY(1,1) NOT NULL,
  [constant] [nvarchar](max) NOT NULL,
  [string] [nvarchar] NOT NULL,
  [file] [nvarchar](max) NOT NULL,
   CONSTRAINT [PK_#__overrider_id] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;


/****** Object:  Table [#__modules_menu]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__modules_menu]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__modules_menu](
	[moduleid] [int] NOT NULL,
	[menuid] [int] NOT NULL,
 CONSTRAINT [PK_#__modules_menu_moduleid] PRIMARY KEY CLUSTERED
(
	[moduleid] ASC,
	[menuid] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;


/****** Object:  Default [DF__#__modul__modul__2FCF1A8A]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__modul__modul__2FCF1A8A]') AND parent_object_id = OBJECT_ID(N'[#__modules_menu]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__modul__modul__2FCF1A8A]') AND type = 'D')
BEGIN
ALTER TABLE [#__modules_menu] ADD  DEFAULT ((0)) FOR [moduleid]
END


End;

/****** Object:  Default [DF__#__modul__menui__30C33EC3]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__modul__menui__30C33EC3]') AND parent_object_id = OBJECT_ID(N'[#__modules_menu]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__modul__menui__30C33EC3]') AND type = 'D')
BEGIN
ALTER TABLE [#__modules_menu] ADD  DEFAULT ((0)) FOR [menuid]
END


End;

INSERT INTO #__modules_menu (moduleid,menuid)
SELECT 1,0
UNION ALL
SELECT 2,0
UNION ALL
SELECT 3,0
UNION ALL
SELECT 4,0
UNION ALL
SELECT 8,0
UNION ALL
SELECT 9,0
UNION ALL
SELECT 10,0
UNION ALL
SELECT 12,0
UNION ALL
SELECT 13,0
UNION ALL
SELECT 14,0
UNION ALL
SELECT 15,0
UNION ALL
SELECT 79,0
UNION ALL
SELECT 80,0


/****** Object:  Table [#__modules]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__modules]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__modules](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](100) NOT NULL,
	[note] [nvarchar](255) NOT NULL,
	[content] [nvarchar](max) NOT NULL,
	[ordering] [int] NOT NULL,
	[position] [nvarchar](50) NULL ,
	[checked_out] [bigint] NOT NULL,
	[checked_out_time] [datetime] NOT NULL,
	[publish_up] [datetime] NOT NULL,
	[publish_down] [datetime] NOT NULL,
	[published] [smallint] NOT NULL,
	[module] [nvarchar](50) NULL,
	[access] [int] NOT NULL,
	[showtitle] [tinyint] NOT NULL,
	[params] [nvarchar](max) NOT NULL,
	[client_id] [smallint] NOT NULL,
	[language] [nvarchar](7) NOT NULL,
 CONSTRAINT [PK_#__modules_id] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__modules]') AND name = N'idx_language')
CREATE NONCLUSTERED INDEX [idx_language] ON [#__modules]
(
	[language] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__modules]') AND name = N'newsfeeds')
CREATE NONCLUSTERED INDEX [newsfeeds] ON [#__modules]
(
	[module] ASC,
	[published] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__modules]') AND name = N'published')
CREATE NONCLUSTERED INDEX [published] ON [#__modules]
(
	[published] ASC,
	[access] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);


/****** Object:  Default [DF__#__modul__title__2180FB33]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__modul__title__2180FB33]') AND parent_object_id = OBJECT_ID(N'[#__modules]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__modul__title__2180FB33]') AND type = 'D')
BEGIN
ALTER TABLE [#__modules] ADD  DEFAULT (N'') FOR [title]
END


End;

/****** Object:  Default [DF__#__module__note__22751F6C]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__module__note__22751F6C]') AND parent_object_id = OBJECT_ID(N'[#__modules]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__module__note__22751F6C]') AND type = 'D')
BEGIN
ALTER TABLE [#__modules] ADD  DEFAULT (N'') FOR [note]
END


End;

/****** Object:  Default [DF__#__modul__order__236943A5]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__modul__order__236943A5]') AND parent_object_id = OBJECT_ID(N'[#__modules]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__modul__order__236943A5]') AND type = 'D')
BEGIN
ALTER TABLE [#__modules] ADD  DEFAULT ((0)) FOR [ordering]
END


End;

/****** Object:  Default [DF__#__modul__posit__245D67DE]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__modul__posit__245D67DE]') AND parent_object_id = OBJECT_ID(N'[#__modules]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__modul__posit__245D67DE]') AND type = 'D')
BEGIN
ALTER TABLE [#__modules] ADD  DEFAULT (NULL) FOR [position]
END


End;

/****** Object:  Default [DF__#__modul__check__25518C17]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__modul__check__25518C17]') AND parent_object_id = OBJECT_ID(N'[#__modules]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__modul__check__25518C17]') AND type = 'D')
BEGIN
ALTER TABLE [#__modules] ADD  DEFAULT ((0)) FOR [checked_out]
END


End;

/****** Object:  Default [DF__#__modul__check__2645B050]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__modul__check__2645B050]') AND parent_object_id = OBJECT_ID(N'[#__modules]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__modul__check__2645B050]') AND type = 'D')
BEGIN
ALTER TABLE [#__modules] ADD  DEFAULT ('1900-01-01 00:00:00') FOR [checked_out_time]
END


End;

/****** Object:  Default [DF__#__modul__publi__2739D489]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__modul__publi__2739D489]') AND parent_object_id = OBJECT_ID(N'[#__modules]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__modul__publi__2739D489]') AND type = 'D')
BEGIN
ALTER TABLE [#__modules] ADD  DEFAULT ('1900-01-01 00:00:00') FOR [publish_up]
END


End;

/****** Object:  Default [DF__#__modul__publi__282DF8C2]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__modul__publi__282DF8C2]') AND parent_object_id = OBJECT_ID(N'[#__modules]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__modul__publi__282DF8C2]') AND type = 'D')
BEGIN
ALTER TABLE [#__modules] ADD  DEFAULT ('1900-01-01 00:00:00') FOR [publish_down]
END


End;

/****** Object:  Default [DF__#__modul__publi__29221CFB]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__modul__publi__29221CFB]') AND parent_object_id = OBJECT_ID(N'[#__modules]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__modul__publi__29221CFB]') AND type = 'D')
BEGIN
ALTER TABLE [#__modules] ADD  DEFAULT ((0)) FOR [published]
END


End;

/****** Object:  Default [DF__#__modul__modul__2A164134]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__modul__modul__2A164134]') AND parent_object_id = OBJECT_ID(N'[#__modules]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__modul__modul__2A164134]') AND type = 'D')
BEGIN
ALTER TABLE [#__modules] ADD  DEFAULT (NULL) FOR [module]
END


End;

/****** Object:  Default [DF__#__modul__acces__2B0A656D]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__modul__acces__2B0A656D]') AND parent_object_id = OBJECT_ID(N'[#__modules]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__modul__acces__2B0A656D]') AND type = 'D')
BEGIN
ALTER TABLE [#__modules] ADD  DEFAULT ((0)) FOR [access]
END


End;

/****** Object:  Default [DF__#__modul__showt__2BFE89A6]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__modul__showt__2BFE89A6]') AND parent_object_id = OBJECT_ID(N'[#__modules]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__modul__showt__2BFE89A6]') AND type = 'D')
BEGIN
ALTER TABLE [#__modules] ADD  DEFAULT ((1)) FOR [showtitle]
END


End;

/****** Object:  Default [DF__#__modul__param__2CF2ADDF]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__modul__param__2CF2ADDF]') AND parent_object_id = OBJECT_ID(N'[#__modules]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__modul__param__2CF2ADDF]') AND type = 'D')
BEGIN
ALTER TABLE [#__modules] ADD  DEFAULT (N'') FOR [params]
END


End;

/****** Object:  Default [DF__#__modul__clien__2DE6D218]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__modul__clien__2DE6D218]') AND parent_object_id = OBJECT_ID(N'[#__modules]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__modul__clien__2DE6D218]') AND type = 'D')
BEGIN
ALTER TABLE [#__modules] ADD  DEFAULT ((0)) FOR [client_id]
END


End;


SET IDENTITY_INSERT #__modules  ON;
INSERT INTO #__modules (id, title, note, content, ordering, position, checked_out,checked_out_time, publish_up, publish_down, published, module, access, showtitle, params,
  client_id, language)
SELECT 1, 'Main Menu', '', '', 1, 'position-7', 0, '1900-01-01 00:00:00', '1900-01-01 00:00:00', '1900-01-01 00:00:00', 1, 'mod_menu', 1, 1, '{"menutype":"mainmenu","startLevel":"0","endLevel":"0","showAllChildren":"0","tag_id":"","class_sfx":"","window_open":"","layout":"","moduleclass_sfx":"_menu","cache":"1","cache_time":"900","cachemode":"itemid"}', 0, '*'
UNION ALL
SELECT 2, 'Login', '', '', 1, 'login', 0, '1900-01-01 00:00:00', '1900-01-01 00:00:00', '1900-01-01 00:00:00', 1, 'mod_login', 1, 1, '', 1, '*'
UNION ALL
SELECT 3, 'Popular Articles', '', '', 3, 'cpanel', 0, '1900-01-01 00:00:00', '1900-01-01 00:00:00', '1900-01-01 00:00:00', 1, 'mod_popular', 3, 1, '{"count":"5","catid":"","user_id":"0","layout":"_:default","moduleclass_sfx":"","cache":"0","automatic_title":"1"}', 1, '*'
UNION ALL
SELECT 4, 'Recently Added Articles', '', '', 4, 'cpanel', 0, '1900-01-01 00:00:00', '1900-01-01 00:00:00', '1900-01-01 00:00:00', 1, 'mod_latest', 3, 1, '{"count":"5","ordering":"c_dsc","catid":"","user_id":"0","layout":"_:default","moduleclass_sfx":"","cache":"0","automatic_title":"1"}', 1, '*'
UNION ALL
SELECT 8, 'Toolbar', '', '', 1, 'toolbar', 0, '1900-01-01 00:00:00', '1900-01-01 00:00:00', '1900-01-01 00:00:00', 1, 'mod_toolbar', 3, 1, '', 1, '*'
UNION ALL
SELECT 9, 'Quick Icons', '', '', 1, 'icon', 0, '1900-01-01 00:00:00', '1900-01-01 00:00:00', '1900-01-01 00:00:00', 1, 'mod_quickicon', 3, 1, '', 1, '*'
UNION ALL
SELECT 10, 'Logged-in Users', '', '', 2, 'cpanel', 0, '1900-01-01 00:00:00', '1900-01-01 00:00:00', '1900-01-01 00:00:00', 1, 'mod_logged', 3, 1, '{"count":"5","name":"1","layout":"_:default","moduleclass_sfx":"","cache":"0","automatic_title":"1"}', 1, '*'
UNION ALL
SELECT 12, 'Admin Menu', '', '', 1, 'menu', 0, '1900-01-01 00:00:00', '1900-01-01 00:00:00', '1900-01-01 00:00:00', 1, 'mod_menu', 3, 1, '{"layout":"","moduleclass_sfx":"","shownew":"1","showhelp":"1","cache":"0"}', 1, '*'
UNION ALL
SELECT 13, 'Admin Submenu', '', '', 1, 'submenu', 0, '1900-01-01 00:00:00', '1900-01-01 00:00:00', '1900-01-01 00:00:00', 1, 'mod_submenu', 3, 1, '', 1, '*'
UNION ALL
SELECT 14, 'User Status', '', '', 2, 'status', 0, '1900-01-01 00:00:00', '1900-01-01 00:00:00', '1900-01-01 00:00:00', 1, 'mod_status', 3, 1, '', 1, '*'
UNION ALL
SELECT 15, 'Title', '', '', 1, 'title', 0, '1900-01-01 00:00:00', '1900-01-01 00:00:00', '1900-01-01 00:00:00', 1, 'mod_title', 3, 1, '', 1, '*'
UNION ALL
SELECT 79, 'Multilanguage status', '', '', 1, 'status', 0, '1900-01-01 00:00:00', '1900-01-01 00:00:00', '1900-01-01 00:00:00', 0, 'mod_multilangstatus', 3, 1, '{"layout":"_:default","moduleclass_sfx":"","cache":"0"}', 1, '*';
UNION ALL
SELECT (80, 'Version', '', '', 1, 'footer', 42, '2012-03-10 18:15:01', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_version', 1, 1, '{"format":"short","product":"1","layout":"_:default","moduleclass_sfx":"","cache":"0"}', 1, '*';
SET IDENTITY_INSERT #__modules  OFF;


/****** Object:  Table [#__menu_types]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__menu_types]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__menu_types](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[menutype] [nvarchar](24) NOT NULL,
	[title] [nvarchar](48) NOT NULL,
	[description] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_#__menu_types_id] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF),
 CONSTRAINT [#__menu_types$idx_menutype] UNIQUE NONCLUSTERED
(
	[menutype] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;


/****** Object:  Default [DF__#__menu___descr__14270015]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__menu___descr__14270015]') AND parent_object_id = OBJECT_ID(N'[#__menu_types]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__menu___descr__14270015]') AND type = 'D')
BEGIN
ALTER TABLE [#__menu_types] ADD  DEFAULT (N'') FOR [description]
END


End;


SET IDENTITY_INSERT #__menu_types  ON;

INSERT INTO #__menu_types (id, menutype, title, description)
SELECT 1, 'mainmenu', 'Main Menu', 'The main menu for the site'
SET IDENTITY_INSERT #__menu_types  OFF;


/****** Object:  Table [#__menu]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__menu]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__menu](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[menutype] [nvarchar](24) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[alias] [nvarchar](255) NOT NULL,
	[note] [nvarchar](255) NOT NULL,
	[path] [nvarchar](1024) NOT NULL,
	[link] [nvarchar](1024) NOT NULL,
	[type] [nvarchar](16) NOT NULL,
	[published] [smallint] NOT NULL,
	[parent_id] [bigint] NOT NULL,
	[level] [bigint] NOT NULL,
	[component_id] [bigint] NOT NULL,
	[ordering] [int] NOT NULL,
	[checked_out] [bigint] NOT NULL,
	[checked_out_time] [datetime] NOT NULL,
	[browserNav] [smallint] NOT NULL,
	[access] [int] NOT NULL,
	[img] [nvarchar](255) NOT NULL,
	[template_style_id] [bigint] NOT NULL,
	[params] [nvarchar](max) NOT NULL,
	[lft] [int] NOT NULL,
	[rgt] [int] NOT NULL,
	[home] [tinyint] NOT NULL,
	[language] [nvarchar](7) NOT NULL,
	[client_id] [smallint] NOT NULL,
 CONSTRAINT [PK_#__menu_id] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF),
 CONSTRAINT [#__menu$idx_client_id_parent_id_alias] UNIQUE NONCLUSTERED
(
	[client_id] ASC,
	[parent_id] ASC,
	[alias] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__menu]') AND name = N'idx_alias')
CREATE NONCLUSTERED INDEX [idx_alias] ON [#__menu]
(
	[alias] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__menu]') AND name = N'idx_componentid')
CREATE NONCLUSTERED INDEX [idx_componentid] ON [#__menu]
(
	[component_id] ASC,
	[menutype] ASC,
	[published] ASC,
	[access] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__menu]') AND name = N'idx_language')
CREATE NONCLUSTERED INDEX [idx_language] ON [#__menu]
(
	[language] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__menu]') AND name = N'idx_left_right')
CREATE NONCLUSTERED INDEX [idx_left_right] ON [#__menu]
(
	[lft] ASC,
	[rgt] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__menu]') AND name = N'idx_menutype')
CREATE NONCLUSTERED INDEX [idx_menutype] ON [#__menu]
(
	[menutype] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__menu]') AND name = N'idx_language')
CREATE NONCLUSTERED INDEX [idx_language] ON [#__menu]
(
	[language] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__menu]') AND name = N'idx_browserNav')
CREATE NONCLUSTERED INDEX [idx_browserNav] ON [#__menu]
(
	[browserNav] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__menu]') AND name = N'idx_home')
CREATE NONCLUSTERED INDEX [idx_home] ON [#__menu]
(
	[home] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__menu]') AND name = N'idx_template_style_id')
CREATE NONCLUSTERED INDEX [idx_template_style_id] ON [#__menu]
(
	[template_style_id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__menu]') AND name = N'idx_img')
CREATE NONCLUSTERED INDEX [idx_img] ON [#__menu]
(
	[img] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);


/****** Object:  Default [DF__#__menu__note__03F0984C]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__menu__note__03F0984C]') AND parent_object_id = OBJECT_ID(N'[#__menu]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__menu__note__03F0984C]') AND type = 'D')
BEGIN
ALTER TABLE [#__menu] ADD  DEFAULT (N'') FOR [note]
END


End;

/****** Object:  Default [DF__#__menu__publis__04E4BC85]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__menu__publis__04E4BC85]') AND parent_object_id = OBJECT_ID(N'[#__menu]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__menu__publis__04E4BC85]') AND type = 'D')
BEGIN
ALTER TABLE [#__menu] ADD  DEFAULT ((0)) FOR [published]
END


End;

/****** Object:  Default [DF__#__menu__parent__05D8E0BE]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__menu__parent__05D8E0BE]') AND parent_object_id = OBJECT_ID(N'[#__menu]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__menu__parent__05D8E0BE]') AND type = 'D')
BEGIN
ALTER TABLE [#__menu] ADD  DEFAULT ((1)) FOR [parent_id]
END


End;

/****** Object:  Default [DF__#__menu__level__06CD04F7]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__menu__level__06CD04F7]') AND parent_object_id = OBJECT_ID(N'[#__menu]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__menu__level__06CD04F7]') AND type = 'D')
BEGIN
ALTER TABLE [#__menu] ADD  DEFAULT ((0)) FOR [level]
END


End;

/****** Object:  Default [DF__#__menu__compon__07C12930]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__menu__compon__07C12930]') AND parent_object_id = OBJECT_ID(N'[#__menu]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__menu__compon__07C12930]') AND type = 'D')
BEGIN
ALTER TABLE [#__menu] ADD  DEFAULT ((0)) FOR [component_id]
END


End;

/****** Object:  Default [DF__#__menu__orderi__08B54D69]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__menu__orderi__08B54D69]') AND parent_object_id = OBJECT_ID(N'[#__menu]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__menu__orderi__08B54D69]') AND type = 'D')
BEGIN
ALTER TABLE [#__menu] ADD  DEFAULT ((0)) FOR [ordering]
END


End;

/****** Object:  Default [DF__#__menu__checke__09A971A2]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__menu__checke__09A971A2]') AND parent_object_id = OBJECT_ID(N'[#__menu]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__menu__checke__09A971A2]') AND type = 'D')
BEGIN
ALTER TABLE [#__menu] ADD  DEFAULT ((0)) FOR [checked_out]
END


End;

/****** Object:  Default [DF__#__menu__checke__0A9D95DB]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__menu__checke__0A9D95DB]') AND parent_object_id = OBJECT_ID(N'[#__menu]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__menu__checke__0A9D95DB]') AND type = 'D')
BEGIN
ALTER TABLE [#__menu] ADD  DEFAULT ('1900-01-01 00:00:00') FOR [checked_out_time]
END


End;

/****** Object:  Default [DF__#__menu__browse__0B91BA14]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__menu__browse__0B91BA14]') AND parent_object_id = OBJECT_ID(N'[#__menu]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__menu__browse__0B91BA14]') AND type = 'D')
BEGIN
ALTER TABLE [#__menu] ADD  DEFAULT ((0)) FOR [browserNav]
END


End;

/****** Object:  Default [DF__#__menu__access__0C85DE4D]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__menu__access__0C85DE4D]') AND parent_object_id = OBJECT_ID(N'[#__menu]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__menu__access__0C85DE4D]') AND type = 'D')
BEGIN
ALTER TABLE [#__menu] ADD  DEFAULT ((0)) FOR [access]
END


End;

/****** Object:  Default [DF__#__menu__templa__0D7A0286]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__menu__templa__0D7A0286]') AND parent_object_id = OBJECT_ID(N'[#__menu]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__menu__templa__0D7A0286]') AND type = 'D')
BEGIN
ALTER TABLE [#__menu] ADD  DEFAULT ((0)) FOR [template_style_id]
END


End;

/****** Object:  Default [DF__#__menu__lft__0E6E26BF]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__menu__lft__0E6E26BF]') AND parent_object_id = OBJECT_ID(N'[#__menu]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__menu__lft__0E6E26BF]') AND type = 'D')
BEGIN
ALTER TABLE [#__menu] ADD  DEFAULT ((0)) FOR [lft]
END


End;

/****** Object:  Default [DF__#__menu__rgt__0F624AF8]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__menu__rgt__0F624AF8]') AND parent_object_id = OBJECT_ID(N'[#__menu]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__menu__rgt__0F624AF8]') AND type = 'D')
BEGIN
ALTER TABLE [#__menu] ADD  DEFAULT ((0)) FOR [rgt]
END


End;

/****** Object:  Default [DF__#__menu__home__10566F31]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__menu__home__10566F31]') AND parent_object_id = OBJECT_ID(N'[#__menu]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__menu__home__10566F31]') AND type = 'D')
BEGIN
ALTER TABLE [#__menu] ADD  DEFAULT ((0)) FOR [home]
END


End;

/****** Object:  Default [DF__#__menu__langua__114A936A]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__menu__langua__114A936A]') AND parent_object_id = OBJECT_ID(N'[#__menu]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__menu__langua__114A936A]') AND type = 'D')
BEGIN
ALTER TABLE [#__menu] ADD  DEFAULT (N'') FOR [language]
END


End;

/****** Object:  Default [DF__#__menu__client__123EB7A3]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__menu__client__123EB7A3]') AND parent_object_id = OBJECT_ID(N'[#__menu]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__menu__client__123EB7A3]') AND type = 'D')
BEGIN
ALTER TABLE [#__menu] ADD  DEFAULT ((0)) FOR [client_id]
END


End;

SET IDENTITY_INSERT #__menu  ON;

INSERT INTO #__menu (id, menutype, title, alias, note, path, link,type, published,parent_id, level, component_id,ordering, checked_out, checked_out_time, browserNav, access, img, template_style_id, params, lft, rgt, home, language, client_id)
SELECT 1, '', 'Menu_Item_Root', 'root', '', '', '', '', 1, 0, 0, 0, 0, 0, '1900-01-01 00:00:00', 0, 0, '', 0, '', 0, 75, 0, '*', 0
UNION ALL
SELECT 101, 'mainmenu', 'Home', 'home', '', 'home', 'index.php?option=com_content&view=article&id=1', 'component', 1, 1, 1, 22, 0, 0, '1900-01-01 00:00:00', 0, 1, '', 0, '{"show_title":"1","link_titles":"0","show_intro":"","show_category":"0","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"0","link_author":"","show_create_date":"0","show_modify_date":"0","show_publish_date":"0","show_item_navigation":"0","show_vote":"0","show_icons":"0","show_print_icon":"0","show_email_icon":"0","show_hits":"0","show_noauth":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":0,"page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0}', 1, 2, 1, '*', 0
UNION ALL
SELECT 107, 'admin', 'MOD_MENU_COM_CONTENT_ARTICLE_MANAGER', 'comcontent', '', 'modmenucomcontent/comcontent', 'index.php?option=com_content', 'component', 1, 128, 2, 20, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:article', 0, '', 48, 51, 0, '*', 1
UNION ALL
SELECT 108, 'admin', 'MOD_MENU_COM_CONTENT_NEW_ARTICLE', 'modmenucomcontentnewarticle', '', 'modmenucomcontent/comcontent/modmenucomcontentnewarticle', 'index.php?option=com_content&task=article.add', 'component', 1, 107, 3, 20, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:newarticle', 0, '', 49, 50, 0, '*', 1
UNION ALL
SELECT 109, 'admin', 'MOD_MENU_CONTROL_PANEL', 'modmenucontrolpanel', '', 'modmenucontrolpanel', 'index.php', 'component', 1, 1, 1, 9, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:cpanel', 0, '', 3, 20, 0, '*', 1
UNION ALL
SELECT 110, 'admin', 'MOD_MENU_CONFIGURATION', 'modmenuconfiguration', '', 'modmenucontrolpanel/modmenuconfiguration', 'index.php?option=com_config', 'component', 1, 109, 2, 23, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:config', 0, '', 4, 5, 0, '*', 1
UNION ALL
SELECT 111, 'admin', 'MOD_MENU_SYSTEM_INFORMATION', 'modmenusysteminformation', '', 'modmenucontrolpanel/modmenusysteminformation', 'index.php?option=com_admin&view=sysinfo', 'component', 1, 109, 2, 3, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:maintenance', 0, '', 6, 7, 0, '*', 1
UNION ALL
SELECT 112, 'admin', 'MOD_MENU_LOGOUT', 'modmenulogout', '', 'modmenucontrolpanel/modmenulogout', 'index.php?option=com_login&task=logout', 'component', 1, 109, 2, 12, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:logout', 0, '', 18, 19, 0, '*', 1
UNION ALL
SELECT 113, 'admin', 'MOD_MENU_MAINTENANCE', 'modmenumaintenance', '', 'modmenucontrolpanel/modmenumaintenance', 'index.php?option=com_checkin', 'component', 1, 109, 2, 7, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:maintenance', 0, '', 8, 15, 0, '*', 1
UNION ALL
SELECT 114, 'admin', 'MOD_MENU_GLOBAL_CHECKIN', 'modmenuglobalcheckin', '', 'modmenucontrolpanel/modmenumaintenance/modmenuglobalcheckin', 'index.php?option=com_checkin', 'component', 1, 113, 3, 7, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:checkin', 0, '', 9, 10, 0, '*', 1
UNION ALL
SELECT 115, 'admin', 'MOD_MENU_CLEAR_CACHE', 'modmenuclearcache', '', 'modmenucontrolpanel/modmenumaintenance/modmenuclearcache', 'index.php?option=com_cache', 'component', 1, 113, 3, 5, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:clear', 0, '', 11, 12, 0, '*', 1
UNION ALL
SELECT 116, 'admin', 'MOD_MENU_PURGE_EXPIRED_CACHE', 'modmenupurgeexpiredcache', '', 'modmenucontrolpanel/modmenumaintenance/modmenupurgeexpiredcache', 'index.php?option=com_cache&view=purge', 'component', 1, 113, 3, 5, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:purge', 0, '', 13, 14, 0, '*', 1
UNION ALL
SELECT 117, 'admin', 'MOD_MENU_COM_USERS_USERS', 'modmenucomusersusers', '', 'modmenucomusersusers', 'index.php?option=com_users&view=users', 'component', 1, 1, 1, 25, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:user', 0, '', 21, 36, 0, '*', 1
UNION ALL
SELECT 118, 'admin', 'MOD_MENU_COM_USERS_USER_MANAGER', 'modmenucomusersusermanager', '', 'modmenucomusersusers/modmenucomusersusermanager', 'index.php?option=com_users&view=users', 'component', 1, 117, 2, 25, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:user', 0, '', 22, 25, 0, '*', 1
UNION ALL
SELECT 119, 'admin', 'MOD_MENU_COM_USERS_ADD_USER', 'modmenucomusersadduser', '', 'modmenucomusersusers/modmenucomusersusermanager/modmenucomusersadduser', 'index.php?option=com_users&task=user.add', 'component', 1, 118, 3, 25, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:newuser', 0, '', 23, 24, 0, '*', 1
UNION ALL
SELECT 120, 'admin', 'MOD_MENU_COM_USERS_GROUPS', 'modmenucomusersgroups', '', 'modmenucomusersusers/modmenucomusersgroups', 'index.php?option=com_users&view=groups', 'component', 1, 117, 2, 25, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:newgroup', 0, '', 26, 29, 0, '*', 1
UNION ALL
SELECT 121, 'admin', 'MOD_MENU_COM_USERS_ADD_GROUP', 'modmenucomusersaddgroup', '', 'modmenucomusersusers/modmenucomusersgroups/modmenucomusersaddgroup', 'index.php?option=com_users&task=group.add', 'component', 1, 120, 3, 25, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:newgroup', 0, '', 27, 28, 0, '*', 1
UNION ALL
SELECT 122, 'admin', 'MOD_MENU_COM_USERS_LEVELS', 'modmenucomuserslevels', '', 'modmenucomusersusers/modmenucomuserslevels', 'index.php?option=com_users&view=levels', 'component', 1, 117, 2, 25, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:levels', 0, '', 30, 33, 0, '*', 1
UNION ALL
SELECT 123, 'admin', 'MOD_MENU_COM_USERS_ADD_LEVEL', 'modmenucomusersaddlevel', '', 'modmenucomusersusers/modmenucomuserslevels/modmenucomusersaddlevel', 'index.php?option=com_users&task=level.add', 'component', 1, 122, 3, 25, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:newlevel', 0, '', 31, 32, 0, '*', 1
UNION ALL
SELECT 124, 'admin', 'MOD_MENU_MASS_MAIL_USERS', 'modmenumassmailusers', '', 'modmenucomusersusers/modmenumassmailusers', 'index.php?option=com_users&view=mail', 'component', 1, 117, 2, 23, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:massmail', 0, '', 34, 35, 0, '*', 1
UNION ALL
SELECT 125, 'admin', 'MOD_MENU_MENUS', 'modmenumenus', '', 'modmenumenus', 'index.php?option=com_menus&view=menus', 'component', 1, 1, 1, 14, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:menumgr', 0, '', 37, 46, 0, '*', 1
UNION ALL
SELECT 126, 'admin', 'MOD_MENU_MENU_MANAGER', 'modmenumenumanager', '', 'modmenumenus/modmenumenumanager', 'index.php?option=com_menus&view=menus', 'component', 1, 125, 2, 14, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:menumgr', 0, '', 38, 41, 0, '*', 1
UNION ALL
SELECT 127, 'admin', 'MOD_MENU_MENU_MANAGER_NEW_MENU', 'modmenumenumanagernewmenu', '', 'modmenumenus/modmenumenumanager/modmenumenumanagernewmenu', 'index.php?option=com_menus&task=menu.add', 'component', 1, 126, 3, 14, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:newarticle', 0, '', 39, 40, 0, '*', 1
UNION ALL
SELECT 128, 'admin', 'MOD_MENU_COM_CONTENT', 'modmenucomcontent', '', 'modmenucomcontent', 'index.php?option=com_content', 'component', 1, 1, 1, 20, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:content', 0, '', 47, 60, 0, '*', 1
UNION ALL
SELECT 129, 'admin', 'MOD_MENU_COM_CONTENT_CATEGORY_MANAGER', 'modmenucomcontentcategorymanager', '', 'modmenucomcontent/modmenucomcontentcategorymanager', 'index.php?option=com_categories&extension=com_content', 'component', 1, 128, 2, 6, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:category', 0, '', 52, 55, 0, '*', 1
UNION ALL
SELECT 130, 'admin', 'MOD_MENU_COM_CONTENT_NEW_CATEGORY', 'modmenucomcontentnewcategory', '', 'modmenucomcontent/modmenucomcontentcategorymanager/modmenucomcontentnewcategory', 'index.php?option=com_categories&task=category.add&extension=com_content', 'component', 1, 129, 3, 6, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:newcategory', 0, '', 53, 54, 0, '*', 1
UNION ALL
SELECT 131, 'admin', 'MOD_MENU_COM_CONTENT_FEATURED', 'modmenucomcontentfeatured', '', 'modmenucomcontent/modmenucomcontentfeatured', 'index.php?option=com_content&view=featured', 'component', 1, 128, 2, 20, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:featured', 0, '', 56, 57, 0, '*', 1
UNION ALL
SELECT 132, 'admin', 'MOD_MENU_MEDIA_MANAGER', 'modmenumediamanager', '', 'modmenucomcontent/modmenumediamanager', 'index.php?option=com_media', 'component', 1, 128, 2, 3, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:media', 0, '', 58, 59, 0, '*', 1
UNION ALL
SELECT 133, 'admin', 'MOD_MENU_EXTENSIONS_EXTENSIONS', 'modmenuextensionsextensions', '', 'modmenuextensionsextensions', 'index.php?option=com_installer', 'component', 1, 1, 1, 10, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:install', 0, '', 61, 72, 0, '*', 1
UNION ALL
SELECT 134, 'admin', 'MOD_MENU_EXTENSIONS_EXTENSION_MANAGER', 'modmenuextensionsextensionmanager', '', 'modmenuextensionsextensions/modmenuextensionsextensionmanager', 'index.php?option=com_installer', 'component', 1, 133, 2, 10, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:install', 0, '', 62, 63, 0, '*', 1
UNION ALL
SELECT 135, 'admin', 'MOD_MENU_EXTENSIONS_MODULE_MANAGER', 'modmenuextensionsmodulemanager', '', 'modmenuextensionsextensions/modmenuextensionsmodulemanager', 'index.php?option=com_modules', 'component', 1, 133, 2, 10, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:module', 0, '', 64, 65, 0, '*', 1
UNION ALL
SELECT 136, 'admin', 'MOD_MENU_EXTENSIONS_PLUGIN_MANAGER', 'modmenuextensionspluginmanager', '', 'modmenuextensionsextensions/modmenuextensionspluginmanager', 'index.php?option=com_plugins', 'component', 1, 133, 2, 10, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:plugin', 0, '', 66, 67, 0, '*', 1
UNION ALL
SELECT 137, 'admin', 'MOD_MENU_EXTENSIONS_TEMPLATE_MANAGER', 'modmenuextensionstemplatemanager', '', 'modmenuextensionsextensions/modmenuextensionstemplatemanager', 'index.php?option=com_templates', 'component', 1, 133, 2, 10, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:themes', 0, '', 68, 69, 0, '*', 1
UNION ALL
SELECT 138, 'admin', 'MOD_MENU_EXTENSIONS_LANGUAGE_MANAGER', 'modmenuextensionslanguagemanager', '', 'modmenuextensionsextensions/modmenuextensionslanguagemanager', 'index.php?option=com_languages', 'component', 1, 133, 2, 11, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:language', 0, '', 70, 71, 0, '*', 1
UNION ALL
SELECT 139, 'admin', 'Separator', 'separator', '', 'modmenucontrolpanel/separator', '', 'separator', 1, 109, 2, 0, 0, 0, '1900-01-01 00:00:00', 0, 1, '', 0, '', 16, 17, 0, '*', 1
UNION ALL
SELECT 140, 'admin', 'COM_MENUS_SUBMENU_MENUS', 'commenussubmenumenus', '', 'modmenumenus/commenussubmenumenus', '', 'menus', 1, 125, 2, 0, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:menu', 0, '', 44, 45, 0, '*', 1
UNION ALL
SELECT 141, 'admin', 'MOD_MENU', 'adminmodmenu', '', 'modmenumenus/adminmodmenu', 'index.php?option=com_menus&view=adminitems', 'component', 1, 125, 2, 14, 0, 0, '1900-01-01 00:00:00', 0, 1, 'class:menu', 0, '', 42, 43, 0, '*', 1
SET IDENTITY_INSERT #__menu  OFF;


/****** Object:  Table [#__languages]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__languages]') AND type in (N'U'))
BEGIN

CREATE TABLE [#__languages](
	[lang_id] [bigint] IDENTITY(1,1) NOT NULL,
	[lang_code] [nvarchar](7) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[title_native] [nvarchar](50) NOT NULL,
	[sef] [nvarchar](50) NOT NULL,
	[image] [nvarchar](50) NOT NULL,
	[description] [nvarchar](512) NOT NULL,
	[metakey] [nvarchar](max) NOT NULL,
	[metadesc] [nvarchar](max) NOT NULL,
	[published] [int] NOT NULL,
	[ordering]  [int] NOT NULL,
	[sitename] [nvarchar] (1024) NOT NULL,
 CONSTRAINT [PK_#__languages_lang_id] PRIMARY KEY CLUSTERED
(
	[lang_id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF),
 CONSTRAINT [#__languages$idx_sef] UNIQUE NONCLUSTERED
(
	[sef] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;


/****** Object:  Default [DF__#__langu__publi__02084FDA]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__langu__publi__02084FDA]') AND parent_object_id = OBJECT_ID(N'[#__languages]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__langu__publi__02084FDA]') AND type = 'D')
BEGIN
ALTER TABLE [#__languages] ADD  DEFAULT ((0)) FOR [published]
END


End;

SET IDENTITY_INSERT #__languages  ON;

INSERT INTO #__languages (lang_id,lang_code,title,title_native,sef,image,description,metakey,metadesc,sitename,published,ordering)
VALUES('1', 'en-GB', 'English (UK)', 'English (UK)', 'en', 'en', '', '', '', '', '1','1');

SET IDENTITY_INSERT #__languages  OFF;


/****** Object:  Table [#__extensions]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__extensions]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__extensions](
	[extension_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[type] [nvarchar](20) NOT NULL,
	[element] [nvarchar](100) NOT NULL,
	[folder] [nvarchar](100) NOT NULL,
	[client_id] [smallint] NOT NULL,
	[enabled] [smallint] NOT NULL,
	[access] [int] NOT NULL,
	[protected] [smallint] NOT NULL,
	[manifest_cache] [nvarchar](max) NOT NULL,
	[params] [nvarchar](max) NOT NULL,
	[custom_data] [nvarchar](max) NOT NULL,
	[system_data] [nvarchar](max) NOT NULL,
	[checked_out] [bigint] NOT NULL,
	[checked_out_time] [datetime] NOT NULL,
	[ordering] [int] NULL,
	[state] [int] NULL,
 CONSTRAINT [PK_#__extensions_extension_id] PRIMARY KEY CLUSTERED
(
	[extension_id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__extensions]') AND name = N'element_clientid')
CREATE NONCLUSTERED INDEX [element_clientid] ON [#__extensions]
(
	[element] ASC,
	[client_id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__extensions]') AND name = N'element_folder_clientid')
CREATE NONCLUSTERED INDEX [element_folder_clientid] ON [#__extensions]
(
	[element] ASC,
	[folder] ASC,
	[client_id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__extensions]') AND name = N'extension')
CREATE NONCLUSTERED INDEX [extension] ON [#__extensions]
(
	[type] ASC,
	[element] ASC,
	[folder] ASC,
	[client_id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

/****** Object:  Default [DF__#__exten__enabl__7A672E12]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__exten__enabl__7A672E12]') AND parent_object_id = OBJECT_ID(N'[#__extensions]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__exten__enabl__7A672E12]') AND type = 'D')
BEGIN
ALTER TABLE [#__extensions] ADD  DEFAULT ((1)) FOR [enabled]
END


End;

/****** Object:  Default [DF__#__exten__acces__7B5B524B]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__exten__acces__7B5B524B]') AND parent_object_id = OBJECT_ID(N'[#__extensions]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__exten__acces__7B5B524B]') AND type = 'D')
BEGIN
ALTER TABLE [#__extensions] ADD  DEFAULT ((1)) FOR [access]
END


End;

/****** Object:  Default [DF__#__exten__prote__7C4F7684]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__exten__prote__7C4F7684]') AND parent_object_id = OBJECT_ID(N'[#__extensions]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__exten__prote__7C4F7684]') AND type = 'D')
BEGIN
ALTER TABLE [#__extensions] ADD  DEFAULT ((0)) FOR [protected]
END


End;

/****** Object:  Default [DF__#__exten__check__7D439ABD]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__exten__check__7D439ABD]') AND parent_object_id = OBJECT_ID(N'[#__extensions]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__exten__check__7D439ABD]') AND type = 'D')
BEGIN
ALTER TABLE [#__extensions] ADD  DEFAULT ((0)) FOR [checked_out]
END


End;

/****** Object:  Default [DF__#__exten__check__7E37BEF6]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__exten__check__7E37BEF6]') AND parent_object_id = OBJECT_ID(N'[#__extensions]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__exten__check__7E37BEF6]') AND type = 'D')
BEGIN
ALTER TABLE [#__extensions] ADD  DEFAULT ('1900-01-01 00:00:00') FOR [checked_out_time]
END


End;

/****** Object:  Default [DF__#__exten__order__7F2BE32F]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__exten__order__7F2BE32F]') AND parent_object_id = OBJECT_ID(N'[#__extensions]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__exten__order__7F2BE32F]') AND type = 'D')
BEGIN
ALTER TABLE [#__extensions] ADD  DEFAULT ((0)) FOR [ordering]
END


End;

/****** Object:  Default [DF__#__exten__state__00200768]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__exten__state__00200768]') AND parent_object_id = OBJECT_ID(N'[#__extensions]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__exten__state__00200768]') AND type = 'D')
BEGIN
ALTER TABLE [#__extensions] ADD  DEFAULT ((0)) FOR [state]
END


End;



SET IDENTITY_INSERT #__extensions  ON;
INSERT INTO #__extensions (extension_id, name, type, element, folder, client_id, enabled, access, protected, manifest_cache, params, custom_data, system_data, checked_out, checked_out_time, ordering, state)
SELECT 1, 'com_mailto', 'component', 'com_mailto', '', 0, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 3, 'com_admin', 'component', 'com_admin', '', 1, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 5, 'com_cache', 'component', 'com_cache', '', 1, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 6, 'com_categories', 'component', 'com_categories', '', 1, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 7, 'com_checkin', 'component', 'com_checkin', '', 1, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 9, 'com_cpanel', 'component', 'com_cpanel', '', 1, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 10, 'com_installer', 'component', 'com_installer', '', 1, 1, 1, 1, '', '{}', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 11, 'com_languages', 'component', 'com_languages', '', 1, 1, 1, 1, '', '{"administrator":"en-GB","site":"en-GB"}', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 12, 'com_login', 'component', 'com_login', '', 1, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 13, 'com_media', 'component', 'com_media', '', 1, 1, 0, 1, '', '{"upload_extensions":"bmp,csv,doc,gif,ico,jpg,jpeg,odg,odp,ods,odt,pdf,png,ppt,swf,txt,xcf,xls,BMP,CSV,DOC,GIF,ICO,JPG,JPEG,ODG,ODP,ODS,ODT,PDF,PNG,PPT,SWF,TXT,XCF,XLS","upload_maxsize":"10","file_path":"images","image_path":"images","restrict_uploads":"1","allowed_media_usergroup":"3","check_mime":"1","image_extensions":"bmp,gif,jpg,png","ignore_extensions":"","upload_mime":"image\\/jpeg,image\\/gif,image\\/png,image\\/bmp,application\\/x-shockwave-flash,application\\/msword,application\\/excel,application\\/pdf,application\\/powerpoint,text\\/plain,application\\/x-zip","upload_mime_illegal":"text\\/html","enable_flash":"0"}', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 14, 'com_menus', 'component', 'com_menus', '', 1, 1, 1, 1, '', '{}', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 16, 'com_modules', 'component', 'com_modules', '', 1, 1, 1, 1, '', '{}', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 18, 'com_plugins', 'component', 'com_plugins', '', 1, 1, 1, 1, '', '{}', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 20, 'com_templates', 'component', 'com_templates', '', 1, 1, 1, 1, '', '{}', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 22, 'com_content', 'component', 'com_content', '', 1, 1, 0, 1, '{"legacy":false,"name":"com_content","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2011 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"1.7.0","description":"COM_CONTENT_XML_DESCRIPTION","group":""}', '{"article_layout":"_:default","show_title":"1","link_titles":"1","show_intro":"1","show_category":"1","link_category":"1","show_parent_category":"0","link_parent_category":"0","show_author":"1","link_author":"0","show_create_date":"0","show_modify_date":"0","show_publish_date":"1","show_item_navigation":"1","show_vote":"0","show_readmore":"1","show_readmore_title":"1","readmore_limit":"100","show_icons":"1","show_print_icon":"1","show_email_icon":"1","show_hits":"1","show_noauth":"0","show_publishing_options":"1","show_article_options":"1","show_urls_images_frontend":"0","show_urls_images_backend":"1","targeta":0,"targetb":0,"targetc":0,"float_intro":"left","float_fulltext":"left","category_layout":"_:blog","show_category_title":"0","show_description":"0","show_description_image":"0","maxLevel":"1","show_empty_categories":"0","show_no_articles":"1","show_subcat_desc":"1","show_cat_num_articles":"0","show_base_description":"1","maxLevelcat":"-1","show_empty_categories_cat":"0","show_subcat_desc_cat":"1","show_cat_num_articles_cat":"1","num_leading_articles":"1","num_intro_articles":"4","num_columns":"2","num_links":"4","multi_column_order":"0","show_subcategory_content":"0","show_pagination_limit":"1","filter_field":"hide","show_headings":"1","list_show_date":"0","date_format":"","list_show_hits":"1","list_show_author":"1","orderby_pri":"order","orderby_sec":"rdate","order_date":"published","show_pagination":"2","show_pagination_results":"1","show_feed_link":"1","feed_summary":"0"}', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 23, 'com_config', 'component', 'com_config', '', 1, 1, 0, 1, '{"legacy":false,"name":"com_config","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2011 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"1.7.0","description":"COM_CONFIG_XML_DESCRIPTION","group":""}', '{"filters":{"1":{"filter_type":"NH","filter_tags":"","filter_attributes":""},"6":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"7":{"filter_type":"NONE","filter_tags":"","filter_attributes":""},"2":{"filter_type":"NH","filter_tags":"","filter_attributes":""},"3":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"4":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"5":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"10":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"12":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"8":{"filter_type":"NONE","filter_tags":"","filter_attributes":""}}}', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 25, 'com_users', 'component', 'com_users', '', 1, 1, 0, 1, '', '{"allowUserRegistration":"1","new_usertype":"2","useractivation":"1","frontend_userparams":"1","mailSubjectPrefix":"","mailBodySuffix":""}', '', '', 0, '1900-01-01 00:00:00', 0, 0

INSERT INTO #__extensions (extension_id, name, type, element, folder, client_id, enabled, access, protected, manifest_cache, params, custom_data, system_data, checked_out, checked_out_time, ordering, state)
SELECT 100, 'PHPMailer', 'library', 'phpmailer', '', 0, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 101, 'SimplePie', 'library', 'simplepie', '', 0, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 102, 'phputf8', 'library', 'phputf8', '', 0, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 103, 'Joomla! Web Application Framework', 'library', 'joomla', '', 0, 1, 1, 0, 'a:11:{s:6:"legacy";b:0;s:4:"name";s:33:"Joomla! Web Application Framework";s:4:"type";s:7:"library";s:12:"creationDate";s:4:"2008";s:6:"author";s:6:"Joomla";s:9:"copyright";s:67:"Copyright (C) 2005 - 2011 Open Source Matters. All rights reserved.";s:11:"authorEmail";s:16:"admin@joomla.org";s:9:"authorUrl";s:21:"http://www.joomla.org";s:7:"version";s:5:"1.6.0";s:11:"description";s:90:"The Joomla! Web Application Framework is the Core of the Joomla! Content Management System";s:5:"group";s:0:"";}', '{}', '', '', 0, '1900-01-01 00:00:00', 0, 0;

INSERT INTO #__extensions (extension_id, name, type, element, folder, client_id, enabled, access, protected, manifest_cache, params, custom_data, system_data, checked_out, checked_out_time, ordering, state)
SELECT 204, 'mod_breadcrumbs', 'module', 'mod_breadcrumbs', '', 0, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 205, 'mod_custom', 'module', 'mod_custom', '', 0, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 206, 'mod_feed', 'module', 'mod_feed', '', 0, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 208, 'mod_login', 'module', 'mod_login', '', 0, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 209, 'mod_menu', 'module', 'mod_menu', '', 0, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 222, 'mod_languages', 'module', 'mod_languages', '', 0, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0

INSERT INTO #__extensions (extension_id, name, type, element, folder, client_id, enabled, access, protected, manifest_cache, params, custom_data, system_data, checked_out, checked_out_time, ordering, state)
SELECT 300, 'mod_custom', 'module', 'mod_custom', '', 1, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 301, 'mod_feed', 'module', 'mod_feed', '', 1, 1, 1, 0, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 302, 'mod_latest', 'module', 'mod_latest', '', 1, 1, 1, 0, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 303, 'mod_logged', 'module', 'mod_logged', '', 1, 1, 1, 0, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 304, 'mod_login', 'module', 'mod_login', '', 1, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 305, 'mod_menu', 'module', 'mod_menu', '', 1, 1, 1, 0, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 307, 'mod_popular', 'module', 'mod_popular', '', 1, 1, 1, 0, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 308, 'mod_quickicon', 'module', 'mod_quickicon', '', 1, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 309, 'mod_status', 'module', 'mod_status', '', 1, 1, 1, 0, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 310, 'mod_submenu', 'module', 'mod_submenu', '', 1, 1, 1, 0, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 311, 'mod_title', 'module', 'mod_title', '', 1, 1, 1, 0, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 312, 'mod_toolbar', 'module', 'mod_toolbar', '', 1, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 313, 'mod_multilangstatus', 'module', 'mod_multilangstatus', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_multilangstatus","type":"module","creationDate":"September 2011","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2011 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"1.7.1","description":"MOD_MULTILANGSTATUS_XML_DESCRIPTION","group":""}', '{"cache":"0"}', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 314, 'mod_version', 'module', 'mod_version', '', 1, 1, 1, 0, '{"legacy":false,"name":"mod_version","type":"module","creationDate":"January 2012","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"2.5.0","description":"MOD_VERSION_XML_DESCRIPTION","group":""}', '{"format":"short","product":"1","cache":"0"}', '', '', 0, '1900-01-01 00:00:00', 0, 0

INSERT INTO #__extensions (extension_id, name, type, element, folder, client_id, enabled, access, protected, manifest_cache, params, custom_data, system_data, checked_out, checked_out_time, ordering, state)
SELECT 401, 'plg_authentication_joomla', 'plugin', 'joomla', 'authentication', 0, 1, 1, 1, '', '{}', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 411, 'plg_editors_none', 'plugin', 'none', 'editors', 0, 1, 1, 1, '', '{}', '', '', 0, '1900-01-01 00:00:00', 2, 0
UNION ALL
SELECT 422, 'plg_system_languagefilter', 'plugin', 'languagefilter', 'system', 0, 0, 1, 1, '', '{}', '', '', 0, '1900-01-01 00:00:00', 1, 0
UNION ALL
SELECT 423, 'plg_system_p3p', 'plugin', 'p3p', 'system', 0, 1, 1, 1, '', '{"headers":"NOI ADM DEV PSAi COM NAV OUR OTRo STP IND DEM"}', '', '', 0, '1900-01-01 00:00:00', 2, 0
UNION ALL
SELECT 424, 'plg_system_cache', 'plugin', 'cache', 'system', 0, 0, 1, 1, '', '{"browsercache":"0","cachetime":"15"}', '', '', 0, '1900-01-01 00:00:00', 3, 0
UNION ALL
SELECT 425, 'plg_system_debug', 'plugin', 'debug', 'system', 0, 1, 1, 0, '', '{"profile":"1","queries":"1","memory":"1","language_files":"1","language_strings":"1","strip-first":"1","strip-prefix":"","strip-suffix":""}', '', '', 0, '1900-01-01 00:00:00', 4, 0
UNION ALL
SELECT 426, 'plg_system_log', 'plugin', 'log', 'system', 0, 1, 1, 1, '', '{}', '', '', 0, '1900-01-01 00:00:00', 5, 0
UNION ALL
SELECT 428, 'plg_system_remember', 'plugin', 'remember', 'system', 0, 1, 1, 1, '', '{}', '', '', 0, '1900-01-01 00:00:00', 7, 0
UNION ALL
SELECT 429, 'plg_system_sef', 'plugin', 'sef', 'system', 0, 1, 1, 0, '', '{}', '', '', 0, '1900-01-01 00:00:00', 8, 0
UNION ALL
SELECT 430, 'plg_system_logout', 'plugin', 'logout', 'system', 0, 1, 1, 1, '', '{}', '', '', 0, '1900-01-01 00:00:00', 9, 0
UNION ALL
SELECT 432, 'plg_user_joomla', 'plugin', 'joomla', 'user', 0, 1, 1, 0, '', '{"autoregister":"1"}', '', '', 0, '1900-01-01 00:00:00', 2, 0
UNION ALL
SELECT 434, 'plg_extension_joomla', 'plugin', 'joomla', 'extension', 0, 1, 1, 1, '', '{}', '', '', 0, '1900-01-01 00:00:00', 1, 0
UNION ALL
SELECT 435, 'plg_content_joomla', 'plugin', 'joomla', 'content', 0, 1, 1, 0, '', '{}', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 436, 'plg_system_languagecode', 'plugin', 'languagecode', 'system', 0, 0, 1, 0, '', '{}', '', '', 0, '1900-01-01 00:00:00', 10, 0
UNION ALL
SELECT 437, 'plg_quickicon_joomlaupdate', 'plugin', 'joomlaupdate', 'quickicon', 0, 1, 1, 1, '', '{}', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 438, 'plg_quickicon_extensionupdate', 'plugin', 'extensionupdate', 'quickicon', 0, 1, 1, 1, '', '{}', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 439, 'plg_captcha_recaptcha', 'plugin', 'recaptcha', 'captcha', 0, 1, 1, 0, '{}', '{"public_key":"","private_key":"","theme":"clean"}', '', '', 0, '1900-01-01 00:00:00', 0, 0

INSERT INTO #__extensions (extension_id, name, type, element, folder, client_id, enabled, access, protected, manifest_cache, params, custom_data, system_data, checked_out, checked_out_time, ordering, state)
SELECT 502, 'system', 'template', 'system', '', 1, 1, 1, 0, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 503, 'system', 'template', 'system', '', 0, 1, 1, 0, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0

INSERT INTO #__extensions (extension_id, name, type, element, folder, client_id, enabled, access, protected, manifest_cache, params, custom_data, system_data, checked_out, checked_out_time, ordering, state)
SELECT 600, 'English (United Kingdom)', 'language', 'en-GB', '', 0, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0
UNION ALL
SELECT 601, 'English (United Kingdom)', 'language', 'en-GB', '', 1, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0;


INSERT INTO #__extensions (extension_id, name, type, element, folder, client_id, enabled, access, protected, manifest_cache, params, custom_data, system_data, checked_out, checked_out_time, ordering, state)
VALUES (700, 'Square One CMS', 'file', 'squareone', '', 0, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0);

INSERT INTO #__extensions (extension_id, name,type, element, folder, client_id, enabled, access, protected, manifest_cache, params, custom_data, system_data, checked_out, checked_out_time, ordering, state) VALUES
(800, 'joomla', 'package', 'pkg_joomla', '', 0, 1, 1, 1, '', '', '', '', 0, '1900-01-01 00:00:00', 0, 0);
SET IDENTITY_INSERT #__extensions  OFF;


/****** Object:  Table [#__content_rating]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__content_rating]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__content_rating](
	[content_id] [int] NOT NULL,
	[rating_sum] [bigint] NOT NULL,
	[rating_count] [bigint] NOT NULL,
	[lastip] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_#__content_rating_content_id] PRIMARY KEY CLUSTERED
(
	[content_id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;

/****** Object:  Default [DF__#__conte__conte__72C60C4A]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__conte__72C60C4A]') AND parent_object_id = OBJECT_ID(N'[#__content_rating]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__conte__72C60C4A]') AND type = 'D')
BEGIN
ALTER TABLE [#__content_rating] ADD  DEFAULT ((0)) FOR [content_id]
END


End;

/****** Object:  Default [DF__#__conte__ratin__73BA3083]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__ratin__73BA3083]') AND parent_object_id = OBJECT_ID(N'[#__content_rating]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__ratin__73BA3083]') AND type = 'D')
BEGIN
ALTER TABLE [#__content_rating] ADD  DEFAULT ((0)) FOR [rating_sum]
END


End;

/****** Object:  Default [DF__#__conte__ratin__74AE54BC]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__ratin__74AE54BC]') AND parent_object_id = OBJECT_ID(N'[#__content_rating]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__ratin__74AE54BC]') AND type = 'D')
BEGIN
ALTER TABLE [#__content_rating] ADD  DEFAULT ((0)) FOR [rating_count]
END


End;

/****** Object:  Default [DF__#__conte__lasti__75A278F5]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__lasti__75A278F5]') AND parent_object_id = OBJECT_ID(N'[#__content_rating]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__lasti__75A278F5]') AND type = 'D')
BEGIN
ALTER TABLE [#__content_rating] ADD  DEFAULT (N'') FOR [lastip]
END


End;


/****** Object:  Table [#__content_frontpage]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__content_frontpage]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__content_frontpage](
	[content_id] [int] NOT NULL,
	[ordering] [int] NOT NULL,
 CONSTRAINT [PK_#__content_frontpage_content_id] PRIMARY KEY CLUSTERED
(
	[content_id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;

/****** Object:  Default [DF__#__conte__conte__6FE99F9F]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__conte__6FE99F9F]') AND parent_object_id = OBJECT_ID(N'[#__content_frontpage]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__conte__6FE99F9F]') AND type = 'D')
BEGIN
ALTER TABLE [#__content_frontpage] ADD  DEFAULT ((0)) FOR [content_id]
END


End;

/****** Object:  Default [DF__#__conte__order__70DDC3D8]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__order__70DDC3D8]') AND parent_object_id = OBJECT_ID(N'[#__content_frontpage]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__order__70DDC3D8]') AND type = 'D')
BEGIN
ALTER TABLE [#__content_frontpage] ADD  DEFAULT ((0)) FOR [ordering]
END


End;


/****** Object:  Table [#__content]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__content]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__content](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[asset_id] [bigint] NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[alias] [nvarchar](255) NOT NULL,
	[title_alias] [nvarchar](255) NOT NULL,
	[introtext] [nvarchar](max) NOT NULL,
	[fulltext] [nvarchar](max) NOT NULL,
	[state] [smallint] NOT NULL,
	[sectionid] [bigint] NOT NULL,
	[mask] [bigint] NOT NULL,
	[catid] [bigint] NOT NULL,
	[created] [datetime] NOT NULL,
	[created_by] [bigint] NOT NULL,
	[created_by_alias] [nvarchar](255) NOT NULL,
	[modified] [datetime] NOT NULL,
	[modified_by] [bigint] NOT NULL,
	[checked_out] [bigint] NOT NULL,
	[checked_out_time] [datetime] NOT NULL,
	[publish_up] [datetime] NOT NULL,
	[publish_down] [datetime] NOT NULL,
	[images] [nvarchar](max) NOT NULL,
	[urls] [nvarchar](max) NOT NULL,
	[attribs] [nvarchar](max) NOT NULL,
	[version] [bigint] NOT NULL,
	[parentid] [bigint] NOT NULL,
	[ordering] [int] NOT NULL,
	[metakey] [nvarchar](max) NOT NULL,
	[metadesc] [nvarchar](max) NOT NULL,
	[access] [bigint] NOT NULL,
	[hits] [bigint] NOT NULL,
	[metadata] [nvarchar](max) NOT NULL,
	[featured] [tinyint] NOT NULL,
	[language] [nvarchar](7) NOT NULL,
	[xreference] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_#__content_id] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__content]') AND name = N'idx_access')
CREATE NONCLUSTERED INDEX [idx_access] ON [#__content]
(
	[access] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__content]') AND name = N'idx_catid')
CREATE NONCLUSTERED INDEX [idx_catid] ON [#__content]
(
	[catid] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__content]') AND name = N'idx_checkout')
CREATE NONCLUSTERED INDEX [idx_checkout] ON [#__content]
(
	[checked_out] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__content]') AND name = N'idx_createdby')
CREATE NONCLUSTERED INDEX [idx_createdby] ON [#__content]
(
	[created_by] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__content]') AND name = N'idx_featured_catid')
CREATE NONCLUSTERED INDEX [idx_featured_catid] ON [#__content]
(
	[featured] ASC,
	[catid] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__content]') AND name = N'idx_language')
CREATE NONCLUSTERED INDEX [idx_language] ON [#__content]
(
	[language] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__content]') AND name = N'idx_state')
CREATE NONCLUSTERED INDEX [idx_state] ON [#__content]
(
	[state] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__content]') AND name = N'idx_xreference')
CREATE NONCLUSTERED INDEX [idx_xreference] ON [#__content]
(
	[xreference] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);


/****** Object:  Default [DF__#__conte__asset__59063A47]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__asset__59063A47]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__asset__59063A47]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT ((0)) FOR [asset_id]
END


End;

/****** Object:  Default [DF__#__conte__title__59FA5E80]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__title__59FA5E80]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__title__59FA5E80]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT (N'') FOR [title]
END


End;

/****** Object:  Default [DF__#__conte__alias__5AEE82B9]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__alias__5AEE82B9]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__alias__5AEE82B9]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT (N'') FOR [alias]
END


End;

/****** Object:  Default [DF__#__conte__title__5BE2A6F2]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__title__5BE2A6F2]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__title__5BE2A6F2]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT (N'') FOR [title_alias]
END


End;

/****** Object:  Default [DF__#__conte__state__5CD6CB2B]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__state__5CD6CB2B]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__state__5CD6CB2B]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT ((0)) FOR [state]
END


End;

/****** Object:  Default [DF__#__conte__secti__5DCAEF64]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__secti__5DCAEF64]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__secti__5DCAEF64]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT ((0)) FOR [sectionid]
END


End;

/****** Object:  Default [DF__#__conten__mask__5EBF139D]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conten__mask__5EBF139D]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conten__mask__5EBF139D]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT ((0)) FOR [mask]
END


End;

/****** Object:  Default [DF__#__conte__catid__5FB337D6]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__catid__5FB337D6]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__catid__5FB337D6]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT ((0)) FOR [catid]
END


End;

/****** Object:  Default [DF__#__conte__creat__60A75C0F]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__creat__60A75C0F]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__creat__60A75C0F]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT ('1900-01-01 00:00:00') FOR [created]
END


End;

/****** Object:  Default [DF__#__conte__creat__619B8048]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__creat__619B8048]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__creat__619B8048]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT ((0)) FOR [created_by]
END


End;

/****** Object:  Default [DF__#__conte__creat__628FA481]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__creat__628FA481]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__creat__628FA481]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT (N'') FOR [created_by_alias]
END


End;

/****** Object:  Default [DF__#__conte__modif__6383C8BA]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__modif__6383C8BA]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__modif__6383C8BA]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT ('1900-01-01 00:00:00') FOR [modified]
END


End;

/****** Object:  Default [DF__#__conte__modif__6477ECF3]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__modif__6477ECF3]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__modif__6477ECF3]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT ((0)) FOR [modified_by]
END


End;

/****** Object:  Default [DF__#__conte__check__656C112C]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__check__656C112C]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__check__656C112C]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT ((0)) FOR [checked_out]
END


End;

/****** Object:  Default [DF__#__conte__check__66603565]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__check__66603565]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__check__66603565]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT ('1900-01-01 00:00:00') FOR [checked_out_time]
END


End;

/****** Object:  Default [DF__#__conte__publi__6754599E]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__publi__6754599E]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__publi__6754599E]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT ('1900-01-01 00:00:00') FOR [publish_up]
END


End;

/****** Object:  Default [DF__#__conte__publi__68487DD7]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__publi__68487DD7]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__publi__68487DD7]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT ('1900-01-01 00:00:00') FOR [publish_down]
END


End;

/****** Object:  Default [DF__#__conte__versi__693CA210]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__versi__693CA210]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__versi__693CA210]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT ((1)) FOR [version]
END


End;

/****** Object:  Default [DF__#__conte__paren__6A30C649]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__paren__6A30C649]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__paren__6A30C649]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT ((0)) FOR [parentid]
END


End;

/****** Object:  Default [DF__#__conte__order__6B24EA82]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__order__6B24EA82]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__order__6B24EA82]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT ((0)) FOR [ordering]
END


End;

/****** Object:  Default [DF__#__conte__acces__6C190EBB]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__acces__6C190EBB]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__acces__6C190EBB]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT ((0)) FOR [access]
END


End;

/****** Object:  Default [DF__#__conten__hits__6D0D32F4]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conten__hits__6D0D32F4]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conten__hits__6D0D32F4]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT ((0)) FOR [hits]
END


End;

/****** Object:  Default [DF__#__conte__featu__6E01572D]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__conte__featu__6E01572D]') AND parent_object_id = OBJECT_ID(N'[#__content]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__conte__featu__6E01572D]') AND type = 'D')
BEGIN
ALTER TABLE [#__content] ADD  DEFAULT ((0)) FOR [featured]
END


End;

SET IDENTITY_INSERT #__content  ON;

INSERT INTO [#__content] (id, asset_id, title, alias, title_alias, introtext, fulltext, state, sectionid, mask, catid, created, created_by, created_by_alias, modified, modified_by, checked_out, checked_out_time, publish_up, publish_down, images, urls, attribs, version, parentid, ordering, metakey, metadesc, access, hits, metadata, featured, language, xreference)
SELECT 1, 20, 'Welcome to Square One', 'welcome-to-square-one', '', '<p>If you are familiar with <a href="http://www.joomla.org">Joomla!</a>, you should find <a href="http://www.squareonecms.org">Square One</a> to be very easy to pick up. The major differences are:</p>\r\n<ul>\r\n<li>Many core extensions were removed from the package</li>\r\n<li>There are no templates except the system template for the front</li>\r\n<li>You can reinstall them by going to the Extensions Manager -&gt; Core Extensions to find and install them remotely</li>\r\n<li>The installer does not contain sample content</li>\r\n<li>Joomla! branding was changed to Square One</li>\r\n</ul>\r\n<p>Other than that, its what you are familiar with!</p>\r\n<h3>If you have a problem</h3>\r\n<p>If you find a bug in Square One, and you can report it on the <a href="http://github.com/square-one/square-one-cms/issues">Square One Github tracker</a>. You will need an account to submit a new issue or to comment. Please check if there is an existing issue related to your report first.</p>', '', 1, 0, 0, 2, '2011-12-06 17:14:11', 42, '', '1900-01-01 00:00:00', 0, 0, '1900-01-01 00:00:00', '2011-12-06 17:14:11', '1900-01-01 00:00:00', '', '', '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","alternative_readmore":"","article_layout":""}', 1, 0, 0, '', '', 1, 1, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''

SET IDENTITY_INSERT #__content  OFF;


/****** Object:  Table [#__categories]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__categories]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__categories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[asset_id] [bigint] NOT NULL,
	[parent_id] [bigint] NOT NULL,
	[lft] [int] NOT NULL,
	[rgt] [int] NOT NULL,
	[level] [bigint] NOT NULL,
	[path] [nvarchar](255) NOT NULL,
	[extension] [nvarchar](50) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[alias] [nvarchar](255) NOT NULL,
	[note] [nvarchar](255) NOT NULL,
	[description] [nvarchar](max) NOT NULL,
	[published] [smallint] NOT NULL,
	[checked_out] [bigint] NOT NULL,
	[checked_out_time] [datetime] NOT NULL,
	[access] [int] NOT NULL,
	[params] [nvarchar](max) NOT NULL,
	[metadesc] [nvarchar](1024) NOT NULL,
	[metakey] [nvarchar](1024) NOT NULL,
	[metadata] [nvarchar](2048) NOT NULL,
	[created_user_id] [bigint] NOT NULL,
	[created_time] [datetime] NOT NULL,
	[modified_user_id] [bigint] NOT NULL,
	[modified_time] [datetime] NOT NULL,
	[hits] [bigint] NOT NULL,
	[language] [nvarchar](7) NOT NULL,
 CONSTRAINT [PK_#__categories_id] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__categories]') AND name = N'cat_idx')
CREATE NONCLUSTERED INDEX [cat_idx] ON [#__categories]
(
	[extension] ASC,
	[published] ASC,
	[access] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__categories]') AND name = N'idx_access')
CREATE NONCLUSTERED INDEX [idx_access] ON [#__categories]
(
	[access] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__categories]') AND name = N'idx_alias')
CREATE NONCLUSTERED INDEX [idx_alias] ON [#__categories]
(
	[alias] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__categories]') AND name = N'idx_checkout')
CREATE NONCLUSTERED INDEX [idx_checkout] ON [#__categories]
(
	[checked_out] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__categories]') AND name = N'idx_language')
CREATE NONCLUSTERED INDEX [idx_language] ON [#__categories]
(
	[language] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__categories]') AND name = N'idx_left_right')
CREATE NONCLUSTERED INDEX [idx_left_right] ON [#__categories]
(
	[lft] ASC,
	[rgt] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__categories]') AND name = N'idx_path')
CREATE NONCLUSTERED INDEX [idx_path] ON [#__categories]
(
	[path] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__categories]') AND name = N'idx_created_user_id')
CREATE NONCLUSTERED INDEX [idx_created_user_id] ON [#__categories]
(
	[created_user_id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__categories]') AND name = N'idx_checked_out_time')
CREATE NONCLUSTERED INDEX [idx_checked_out_time] ON [#__categories]
(
	[checked_out_time] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__categories]') AND name = N'idx_asset_id')
CREATE NONCLUSTERED INDEX [idx_asset_id] ON [#__categories]
(
	[asset_id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);


/****** Object:  Default [DF__#__categ__asset__276EDEB3]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__categ__asset__276EDEB3]') AND parent_object_id = OBJECT_ID(N'[#__categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__categ__asset__276EDEB3]') AND type = 'D')
BEGIN
ALTER TABLE [#__categories] ADD  DEFAULT ((0)) FOR [asset_id]
END


End;

/****** Object:  Default [DF__#__categ__paren__286302EC]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__categ__paren__286302EC]') AND parent_object_id = OBJECT_ID(N'[#__categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__categ__paren__286302EC]') AND type = 'D')
BEGIN
ALTER TABLE [#__categories] ADD  DEFAULT ((0)) FOR [parent_id]
END


End;

/****** Object:  Default [DF__#__cater__lft__29572725]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__cater__lft__29572725]') AND parent_object_id = OBJECT_ID(N'[#__categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__cater__lft__29572725]') AND type = 'D')
BEGIN
ALTER TABLE [#__categories] ADD  DEFAULT ((0)) FOR [lft]
END


End;

/****** Object:  Default [DF__#__cater__rgt__2A4B4B5E]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__cater__rgt__2A4B4B5E]') AND parent_object_id = OBJECT_ID(N'[#__categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__cater__rgt__2A4B4B5E]') AND type = 'D')
BEGIN
ALTER TABLE [#__categories] ADD  DEFAULT ((0)) FOR [rgt]
END


End;

/****** Object:  Default [DF__#__categ__level__2B3F6F97]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__categ__level__2B3F6F97]') AND parent_object_id = OBJECT_ID(N'[#__categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__categ__level__2B3F6F97]') AND type = 'D')
BEGIN
ALTER TABLE [#__categories] ADD  DEFAULT ((0)) FOR [level]
END


End;

/****** Object:  Default [DF__#__cate__path__2C3393D0]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__cate__path__2C3393D0]') AND parent_object_id = OBJECT_ID(N'[#__categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__cate__path__2C3393D0]') AND type = 'D')
BEGIN
ALTER TABLE [#__categories] ADD  DEFAULT (N'') FOR [path]
END


End;

/****** Object:  Default [DF__#__categ__exten__2D27B809]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__categ__exten__2D27B809]') AND parent_object_id = OBJECT_ID(N'[#__categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__categ__exten__2D27B809]') AND type = 'D')
BEGIN
ALTER TABLE [#__categories] ADD  DEFAULT (N'') FOR [extension]
END


End;

/****** Object:  Default [DF__#__categ__alias__2E1BDC42]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__categ__alias__2E1BDC42]') AND parent_object_id = OBJECT_ID(N'[#__categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__categ__alias__2E1BDC42]') AND type = 'D')
BEGIN
ALTER TABLE [#__categories] ADD  DEFAULT (N'') FOR [alias]
END


End;

/****** Object:  Default [DF__#__cate__note__2F10007B]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__cate__note__2F10007B]') AND parent_object_id = OBJECT_ID(N'[#__categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__cate__note__2F10007B]') AND type = 'D')
BEGIN
ALTER TABLE [#__categories] ADD  DEFAULT (N'') FOR [note]
END


End;

/****** Object:  Default [DF__#__categ__descr__300424B4]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__categ__descr__300424B4]') AND parent_object_id = OBJECT_ID(N'[#__categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__categ__descr__300424B4]') AND type = 'D')
BEGIN
ALTER TABLE [#__categories] ADD  DEFAULT (N'') FOR [description]
END


End;

/****** Object:  Default [DF__#__categ__publi__30F848ED]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__categ__publi__30F848ED]') AND parent_object_id = OBJECT_ID(N'[#__categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__categ__publi__30F848ED]') AND type = 'D')
BEGIN
ALTER TABLE [#__categories] ADD  DEFAULT ((0)) FOR [published]
END


End;

/****** Object:  Default [DF__#__categ__check__31EC6D26]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__categ__check__31EC6D26]') AND parent_object_id = OBJECT_ID(N'[#__categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__categ__check__31EC6D26]') AND type = 'D')
BEGIN
ALTER TABLE [#__categories] ADD  DEFAULT ((0)) FOR [checked_out]
END


End;

/****** Object:  Default [DF__#__categ__check__32E0915F]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__categ__check__32E0915F]') AND parent_object_id = OBJECT_ID(N'[#__categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__categ__check__32E0915F]') AND type = 'D')
BEGIN
ALTER TABLE [#__categories] ADD  DEFAULT ('1900-01-01 00:00:00') FOR [checked_out_time]
END


End;

/****** Object:  Default [DF__#__categ__acces__33D4B598]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__categ__acces__33D4B598]') AND parent_object_id = OBJECT_ID(N'[#__categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__categ__acces__33D4B598]') AND type = 'D')
BEGIN
ALTER TABLE [#__categories] ADD  DEFAULT ((0)) FOR [access]
END


End;

/****** Object:  Default [DF__#__categ__param__34C8D9D1]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__categ__param__34C8D9D1]') AND parent_object_id = OBJECT_ID(N'[#__categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__categ__param__34C8D9D1]') AND type = 'D')
BEGIN
ALTER TABLE [#__categories] ADD  DEFAULT (N'') FOR [params]
END


End;

/****** Object:  Default [DF__#__categ__creat__35BCFE0A]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__categ__creat__35BCFE0A]') AND parent_object_id = OBJECT_ID(N'[#__categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__categ__creat__35BCFE0A]') AND type = 'D')
BEGIN
ALTER TABLE [#__categories] ADD  DEFAULT ((0)) FOR [created_user_id]
END


End;

/****** Object:  Default [DF__#__categ__creat__36B12243]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__categ__creat__36B12243]') AND parent_object_id = OBJECT_ID(N'[#__categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__categ__creat__36B12243]') AND type = 'D')
BEGIN
ALTER TABLE [#__categories] ADD  DEFAULT ('1900-01-01 00:00:00') FOR [created_time]
END


End;

/****** Object:  Default [DF__#__categ__modif__37A5467C]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__categ__modif__37A5467C]') AND parent_object_id = OBJECT_ID(N'[#__categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__categ__modif__37A5467C]') AND type = 'D')
BEGIN
ALTER TABLE [#__categories] ADD  DEFAULT ((0)) FOR [modified_user_id]
END


End;

/****** Object:  Default [DF__#__categ__modif__38996AB5]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__categ__modif__38996AB5]') AND parent_object_id = OBJECT_ID(N'[#__categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__categ__modif__38996AB5]') AND type = 'D')
BEGIN
ALTER TABLE [#__categories] ADD  DEFAULT ('1900-01-01 00:00:00') FOR [modified_time]
END


End;

/****** Object:  Default [DF__#__cate__hits__398D8EEE]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__cate__hits__398D8EEE]') AND parent_object_id = OBJECT_ID(N'[#__categories]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__cate__hits__398D8EEE]') AND type = 'D')
BEGIN
ALTER TABLE [#__categories] ADD  DEFAULT ((0)) FOR [hits]
END


End;

SET IDENTITY_INSERT #__categories  ON;

INSERT INTO #__categories (id, asset_id, parent_id, lft, rgt,level, path, extension, title, alias, note, description, published, checked_out, checked_out_time, access, params, metadesc, metakey, metadata, created_user_id,created_time, modified_user_id, modified_time, hits,language)
SELECT 1, 0, 0, 0, 13, 0, '', 'system', 'ROOT', 'root', '', '', 1, 0, '1900-01-01 00:00:00', 1, '{}', '', '', '', 0, '2009-10-18 16:07:09', 0, '1900-01-01 00:00:00', 0, '*'
UNION ALL
SELECT 2, 19, 1, 1, 2, 1, 'uncategorised', 'com_content', 'Uncategorised', 'uncategorised', '', '', 1, 0, '1900-01-01 00:00:00', 1, '{"target":"","image":""}', '', '', '{"page_title":"","author":"","robots":""}', 42, '2010-06-28 13:26:37', 0, '1900-01-01 00:00:00', 0, '*'
UNION ALL
SELECT 3, 21, 1, 3, 4, 1, 'uncategorised', 'com_users', 'Uncategorised', 'uncategorised', '', '', 1, 0, '1900-01-01 00:00:00', 1, '{"target":"","image":""}', '', '', '{"page_title":"","author":"","robots":""}', 42, '2010-06-28 13:28:33', 0, '1900-01-01 00:00:00', 0, '*'

SET IDENTITY_INSERT #__categories  OFF;


/****** Object:  Table [#__user_notes]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__user_notes]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__user_notes](
 [id] [bigint] IDENTITY(1,1) NOT NULL,
 [user_id] [bigint] NOT NULL,
 [catid] [bigint] NOT NULL,
 [subject] [nvarchar](100) NOT NULL,
 [body] [nvarchar](max) NOT NULL,
 [state] [smallint] NOT NULL,
 [checked_out] [bigint] NOT NULL,
 [checked_out_time] [datetime2](0) NOT NULL,
 [created_user_id] [bigint] NOT NULL,
 [created_time] [datetime2](0) NOT NULL,
 [modified_user_id] [bigint] NOT NULL,
 [modified_time] [datetime2](0) NOT NULL,
 [review_time] [datetime2](0) NOT NULL,
 [publish_up] [datetime2](0) NOT NULL,
 [publish_down] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_#__user_notes_id] PRIMARY KEY CLUSTERED
(
 [id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__user_notes]') AND name = N'idx_category_id')
CREATE NONCLUSTERED INDEX [idx_category_id] ON [#__user_notes]
(
 [catid] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF)

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__user_notes]') AND name = N'idx_user_id')
CREATE NONCLUSTERED INDEX [idx_user_id] ON [#__user_notes]
(
 [user_id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF)
END;

/****** Object:  Default [DF__#__user___user___2610A626]    Script Date: 12/30/2011 16:12:16 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__user___user___2610A626]') AND parent_object_id = OBJECT_ID(N'[#__user_notes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__user___user___2610A626]') AND type = 'D')
BEGIN
ALTER TABLE [#__user_notes] ADD  DEFAULT ((0)) FOR [user_id]
END

End;

/****** Object:  Default [DF__#__user___catid__2704CA5F]    Script Date: 12/30/2011 16:12:16 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__user___catid__2704CA5F]') AND parent_object_id = OBJECT_ID(N'[#__user_notes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__user___catid__2704CA5F]') AND type = 'D')
BEGIN
ALTER TABLE [#__user_notes] ADD  DEFAULT ((0)) FOR [catid]
END

End;

/****** Object:  Default [DF__#__user___subje__27F8EE98]    Script Date: 12/30/2011 16:12:16 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__user___subje__27F8EE98]') AND parent_object_id = OBJECT_ID(N'[#__user_notes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__user___subje__27F8EE98]') AND type = 'D')
BEGIN
ALTER TABLE [#__user_notes] ADD  DEFAULT (N'') FOR [subject]
END

End;

/****** Object:  Default [DF__#__user___state__28ED12D1]    Script Date: 12/30/2011 16:12:16 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__user___state__28ED12D1]') AND parent_object_id = OBJECT_ID(N'[#__user_notes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__user___state__28ED12D1]') AND type = 'D')
BEGIN
ALTER TABLE [#__user_notes] ADD  DEFAULT ((0)) FOR [state]
END

End;

/****** Object:  Default [DF__#__user___check__29E1370A]    Script Date: 12/30/2011 16:12:16 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__user___check__29E1370A]') AND parent_object_id = OBJECT_ID(N'[#__user_notes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__user___check__29E1370A]') AND type = 'D')
BEGIN
ALTER TABLE [#__user_notes] ADD  DEFAULT ((0)) FOR [checked_out]
END

End;

/****** Object:  Default [DF__#__user___check__2AD55B43]    Script Date: 12/30/2011 16:12:16 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__user___check__2AD55B43]') AND parent_object_id = OBJECT_ID(N'[#__user_notes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__user___check__2AD55B43]') AND type = 'D')
BEGIN
ALTER TABLE [#__user_notes] ADD  DEFAULT (getdate()) FOR [checked_out_time]
END

End;

/****** Object:  Default [DF__#__user___creat__2BC97F7C]    Script Date: 12/30/2011 16:12:16 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__user___creat__2BC97F7C]') AND parent_object_id = OBJECT_ID(N'[#__user_notes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__user___creat__2BC97F7C]') AND type = 'D')
BEGIN
ALTER TABLE [#__user_notes] ADD  DEFAULT ((0)) FOR [created_user_id]
END

End;

/****** Object:  Default [DF__#__user___creat__2CBDA3B5]    Script Date: 12/30/2011 16:12:16 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__user___creat__2CBDA3B5]') AND parent_object_id = OBJECT_ID(N'[#__user_notes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__user___creat__2CBDA3B5]') AND type = 'D')
BEGIN
ALTER TABLE [#__user_notes] ADD  DEFAULT (getdate()) FOR [created_time]
END

End;

/****** Object:  Default [DF__#__user___modif__2DB1C7EE]    Script Date: 12/30/2011 16:12:16 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__user___modif__2DB1C7EE]') AND parent_object_id = OBJECT_ID(N'[#__user_notes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__user___modif__2DB1C7EE]') AND type = 'D')
BEGIN
ALTER TABLE [#__user_notes] ADD  DEFAULT (getdate()) FOR [modified_time]
END

End;

/****** Object:  Default [DF__#__user___revie__2EA5EC27]    Script Date: 12/30/2011 16:12:16 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__user___revie__2EA5EC27]') AND parent_object_id = OBJECT_ID(N'[#__user_notes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__user___revie__2EA5EC27]') AND type = 'D')
BEGIN
ALTER TABLE [#__user_notes] ADD  DEFAULT (getdate()) FOR [review_time]
END

End;

/****** Object:  Default [DF__#__user___publi__2F9A1060]    Script Date: 12/30/2011 16:12:16 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__user___publi__2F9A1060]') AND parent_object_id = OBJECT_ID(N'[#__user_notes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__user___publi__2F9A1060]') AND type = 'D')
BEGIN
ALTER TABLE [#__user_notes] ADD  DEFAULT (getdate()) FOR [publish_up]
END

End;

/****** Object:  Default [DF__#__user___publi__308E3499]    Script Date: 12/30/2011 16:12:16 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__user___publi__308E3499]') AND parent_object_id = OBJECT_ID(N'[#__user_notes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__user___publi__308E3499]') AND type = 'D')
BEGIN
ALTER TABLE [#__user_notes] ADD  DEFAULT (getdate()) FOR [publish_down]
END

End;


/****** Object:  Table [#__user_profiles]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__user_profiles]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__user_profiles](
 [user_id] [int] NOT NULL,
 [profile_key] [nvarchar](100) NOT NULL,
 [profile_value] [nvarchar](255) NOT NULL,
 [ordering] [int] NOT NULL,
 CONSTRAINT [#__user_profiles$idx_user_id_profile_key] UNIQUE CLUSTERED
(
 [user_id] ASC,
 [profile_key] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;


/****** Object:  Table [#__assets]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__assets]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__assets](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[parent_id] [int] NOT NULL,
	[lft] [int] NOT NULL,
	[rgt] [int] NOT NULL,
	[level] [bigint] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[title] [nvarchar](100) NOT NULL,
	[rules] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_#__assets_id] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF),
 CONSTRAINT [#__assets$idx_asset_name] UNIQUE NONCLUSTERED
(
	[name] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__assets]') AND name = N'idx_lft_rgt')
CREATE NONCLUSTERED INDEX [idx_lft_rgt] ON [#__assets]
(
	[lft] ASC,
	[rgt] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__assets]') AND name = N'idx_parent_id')
CREATE NONCLUSTERED INDEX [idx_parent_id] ON [#__assets]
(
	[parent_id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);


/****** Object:  Default [DF__#__asset__paren__7E6CC920]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__asset__paren__7E6CC920]') AND parent_object_id = OBJECT_ID(N'[#__assets]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__asset__paren__7E6CC920]') AND type = 'D')
BEGIN
ALTER TABLE [#__assets] ADD  DEFAULT ((0)) FOR [parent_id]
END


End;

/****** Object:  Default [DF__#__assets__lft__7F60ED59]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__assets__lft__7F60ED59]') AND parent_object_id = OBJECT_ID(N'[#__assets]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__assets__lft__7F60ED59]') AND type = 'D')
BEGIN
ALTER TABLE [#__assets] ADD  DEFAULT ((0)) FOR [lft]
END


End;

/****** Object:  Default [DF__#__assets__rgt__00551192]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__assets__rgt__00551192]') AND parent_object_id = OBJECT_ID(N'[#__assets]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__assets__rgt__00551192]') AND type = 'D')
BEGIN
ALTER TABLE [#__assets] ADD  DEFAULT ((0)) FOR [rgt]
END


End;

ALTER TABLE [#__content] ADD tags nvarchar(MAX) NULL;

SET IDENTITY_INSERT #__assets  ON;

INSERT INTO #__assets (id, parent_id, lft, rgt, level, name, title, rules)
SELECT 1,0,1,42,0,'root.1','Root Asset','{"core.login.site":{"6":1,"2":1},"core.login.admin":{"6":1},"core.admin":{"8":1},"core.manage":{"7":1},"core.create":{"6":1,"3":1},"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1},"core.edit.own":{"6":1,"3":1}}'
UNION ALL
SELECT 2,1,2,3,1,'com_admin','com_admin','{}'
UNION ALL
SELECT 3,1,4,5,1,'com_cache','com_cache','{"core.admin":{"7":1},"core.manage":{"7":1}}'
UNION ALL
SELECT 4,1,6,7,1,'com_checkin','com_checkin','{"core.admin":{"7":1},"core.manage":{"7":1}}'
UNION ALL
SELECT 5,1,8,9,1,'com_config','com_config','{}'
UNION ALL
SELECT 6,1,10,15,1,'com_content','com_content','{"core.admin":{"7":1},"core.manage":{"6":1},"core.create":{"3":1},"core.delete":[],"core.edit":{"4":1},"core.edit.state":{"5":1},"core.edit.own":[]}'
UNION ALL
SELECT 7,1,16,17,1,'com_cpanel','com_cpanel','{}'
UNION ALL
SELECT 8,1,18,19,1,'com_installer','com_installer','{"core.admin":{"7":1},"core.manage":{"7":1},"core.delete":[],"core.edit.state":[]}'
UNION ALL
SELECT 9,1,20,21,1,'com_languages','com_languages','{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'
UNION ALL
SELECT 10,1,22,23,1,'com_login','com_login','{}'
UNION ALL
SELECT 11,1,24,25,1,'com_mailto','com_mailto','{}'
UNION ALL
SELECT 12,1,26,27,1,'com_massmail','com_massmail','{}'
UNION ALL
SELECT 13,1,28,29,1,'com_media','com_media','{"core.admin":{"7":1},"core.manage":{"6":1},"core.create":{"3":1},"core.delete":{"5":1}}'
UNION ALL
SELECT 14,1,30,31,1,'com_menus','com_menus','{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'
UNION ALL
SELECT 15,1,32,33,1,'com_modules','com_modules','{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'
UNION ALL
SELECT 16,1,34,35,1,'com_plugins','com_plugins','{"core.admin":{"7":1},"core.manage":[],"core.edit":[],"core.edit.state":[]}'
UNION ALL
SELECT 17,1,36,37,1,'com_templates','com_templates','{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'
UNION ALL
SELECT 18,1,38,41,1,'com_users','com_users','{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.own":{"6":1},"core.edit.state":[]}'
UNION ALL
SELECT 19,6,11,14,2,'com_content.category.2','Uncategorised','{"core.create":{"8":1},"core.delete":[],"core.edit":[],"core.edit.state":[],"core.edit.own":[]}'
UNION ALL
SELECT 20,19,12,13,3,'com_content.article.1','Welcome to Square One','{"core.delete":[],"core.edit":[],"core.edit.state":[]}'
UNION ALL
SELECT 21,18,39,40,1,'com_users.notes.category.3','Uncategorised','{"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}';

SET IDENTITY_INSERT #__assets  OFF;


/****** Object:  Table [#__usergroups]    Script Date: 11/08/2010 18:41:22 ******/


SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[#__usergroups]') AND type in (N'U'))
BEGIN
CREATE TABLE [#__usergroups](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[parent_id] [bigint] NOT NULL,
	[lft] [bigint] NOT NULL,
	[rgt] [bigint] NOT NULL,
	[title] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_#__usergroups_id] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF),
 CONSTRAINT [#__usergroups$idx_usergroup_parent_title_lookup] UNIQUE NONCLUSTERED
(
	[title] ASC,
	[parent_id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__usergroups]') AND name = N'idx_usergroup_title_lookup')
CREATE NONCLUSTERED INDEX [idx_usergroup_title_lookup] ON [#__usergroups]
(
	[title] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__usergroups]') AND name = N'idx_usergroup_adjacency_lookup')
CREATE NONCLUSTERED INDEX [idx_usergroup_adjacency_lookup] ON [#__usergroups]
(
	[parent_id] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[#__usergroups]') AND name = N'idx_usergroup_nested_set_lookup')
CREATE NONCLUSTERED INDEX [idx_usergroup_nested_set_lookup] ON [#__usergroups]
(
	[lft] ASC,
	[rgt] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF);


/****** Object:  Default [DF__#__userg__paren__72910220]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__userg__paren__72910220]') AND parent_object_id = OBJECT_ID(N'[#__usergroups]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__userg__paren__72910220]') AND type = 'D')
BEGIN
ALTER TABLE [#__usergroups] ADD  DEFAULT ((0)) FOR [parent_id]
END


End;

/****** Object:  Default [DF__#__usergro__lft__73852659]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__usergro__lft__73852659]') AND parent_object_id = OBJECT_ID(N'[#__usergroups]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__usergro__lft__73852659]') AND type = 'D')
BEGIN
ALTER TABLE [#__usergroups] ADD  DEFAULT ((0)) FOR [lft]
END


End;

/****** Object:  Default [DF__#__usergro__rgt__74794A92]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__usergro__rgt__74794A92]') AND parent_object_id = OBJECT_ID(N'[#__usergroups]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__usergro__rgt__74794A92]') AND type = 'D')
BEGIN
ALTER TABLE [#__usergroups] ADD  DEFAULT ((0)) FOR [rgt]
END


End;

/****** Object:  Default [DF__#__userg__title__756D6ECB]    Script Date: 11/08/2010 18:41:22 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[DF__#__userg__title__756D6ECB]') AND parent_object_id = OBJECT_ID(N'[#__usergroups]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__#__userg__title__756D6ECB]') AND type = 'D')
BEGIN
ALTER TABLE [#__usergroups] ADD  DEFAULT (N'') FOR [title]
END


End;


SET IDENTITY_INSERT #__usergroups  ON;
INSERT INTO #__usergroups (id ,parent_id ,lft ,rgt ,title)
SELECT 1, 0, 1, 20, 'Public'
UNION ALL
SELECT 2, 1, 6, 17, 'Registered'
UNION ALL
SELECT 3, 2, 7, 14, 'Author'
UNION ALL
SELECT 4, 3, 8, 11, 'Editor'
UNION ALL
SELECT 5, 4, 9, 10, 'Publisher'
UNION ALL
SELECT 6, 1, 2, 5, 'Manager'
UNION ALL
SELECT 7, 6, 3, 4, 'Administrator'
UNION ALL
SELECT 8, 1, 18, 19, 'Super Users';

SET IDENTITY_INSERT #__usergroups  OFF;


