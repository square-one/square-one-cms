ALTER TABLE [#__users] ADD [lastResetTime] [datetime] NOT NULL;
ALTER TABLE [#__users] ADD [resetCount] [int] NOT NULL;