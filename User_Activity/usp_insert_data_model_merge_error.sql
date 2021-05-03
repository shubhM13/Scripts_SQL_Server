/****** Object:  StoredProcedure [AUDIT].[spGetErrorInfo]    Script Date: 03/05/2021 1:06:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Proc 

as
begin
insert into [AUDIT].[data_model_merge_error_log](  
ErrorLine, ErrorMessage, ErrorNumber,  
ErrorProcedure,ErrorSeverity, ErrorState,  
DateErrorRaised  
)  
SELECT  
ERROR_LINE () as ErrorLine,  
Error_Message() as ErrorMessage,  
Error_Number() as ErrorNumber,  
Error_Procedure() as 'Proc',  
Error_Severity() as ErrorSeverity,  
Error_State() as ErrorState,  
GETDATE () as DateErrorRaised 
end  
GO


