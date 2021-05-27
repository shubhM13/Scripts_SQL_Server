/*******************************************
 Name 		: [AUDIT].[usp_insert_data_model_merge_error]
 Author     : Shubham Mishra
 Created On : 26th April, 2021
 PURPOSE    : DM Layer Log Framework
 *******************************************/
--drop procedure [AUDIT].[usp_insert_data_model_merge_error];
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [AUDIT].[usp_insert_data_model_merge_error] (@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL)
AS
BEGIN
	INSERT INTO [AUDIT].[data_model_merge_error_log] (
		ErrorLine
		,ErrorMessage
		,ErrorNumber
		,ErrorProcedure
		,ErrorSeverity
		,ErrorState
		,DateErrorRaised
		,pipeline_name
		,run_id
		)
	SELECT ERROR_LINE() AS ErrorLine
		,Error_Message() AS ErrorMessage
		,Error_Number() AS ErrorNumber
		,Error_Procedure() AS 'Proc'
		,Error_Severity() AS ErrorSeverity
		,Error_State() AS ErrorState
		,GETDATE() AS DateErrorRaised
		,@pipeline_name
		,@run_id
END
GO

