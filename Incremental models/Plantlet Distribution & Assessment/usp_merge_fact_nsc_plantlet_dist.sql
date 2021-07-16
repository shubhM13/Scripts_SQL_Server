/*******************************************
Name : dm.usp_merge_fact_nsc_plantlet_distribution
Author : Shubham Mishra
Created On : 08, Jul, 2021
PURPOSE : Data Model Incremental Setup
*******************************************/
--drop procedure dm.usp_merge_fact_nsc_plantlet_distribution
CREATE PROCEDURE dm.usp_merge_fact_nsc_plantlet_distribution (
	@pipeline_name AS VARCHAR(100) = NULL
	,@run_id AS VARCHAR(100) = NULL
	)
AS
BEGIN
	DECLARE @ERROR_PROC VARCHAR(5000)
		,@ROW INT

	SET @ERROR_PROC = '[AUDIT].[usp_insert_data_model_merge_error]'

	BEGIN TRY
		MERGE dm.fact_nsc_plantlet_distribution AS D
		USING dm.view_fact_nsc_plantlet_distribution AS S
			ON (D.interaction_type = S.interaction_type)
		WHEN NOT MATCHED BY TARGET
			THEN
				INSERT (
					[movementId]
					,[interaction_type]
					,[movement_type]
					,[movement_status]
					,[varietyId]
					,[propagationMethod]
					,[shipmentIdentifier]
					,[start_end_EntityId]
					,[start_end_GeoNodeId]
					,[sender_receiver_Id]
					,[sent_received_date_key]
					,[sent_received_Qty]
					,[price.amount]
					,[price.currencyCode]
					,[costOfProduction.amount]
					,[costOfProduction.currencyCode]
					,[auditInfo.createdBy]
					,[auditInfo.createdOn]
					,[auditInfo.modifiedBy]
					,[auditInfo.modifiedOn]
					,[auditInfo.requestedBy]
					,[auditInfo.modifiedReasonCode]
					,[auditInfo.channel]
					,[lossReason]
					,[distributionPurpose]
					,[start_end_entity_primary_contact]
					)
				VALUES (
					S.[movementId]
					,S.[interaction_type]
					,S.[movement_type]
					,S.[movement_status]
					,S.[varietyId]
					,S.[propagationMethod]
					,S.[shipmentIdentifier]
					,S.[start_end_EntityId]
					,S.[start_end_GeoNodeId]
					,S.[sender_receiver_Id]
					,S.[sent_received_date_key]
					,S.[sent_received_Qty]
					,S.[price.amount]
					,S.[price.currencyCode]
					,S.[costOfProduction.amount]
					,S.[costOfProduction.currencyCode]
					,S.[auditInfo.createdBy]
					,S.[auditInfo.createdOn]
					,S.[auditInfo.modifiedBy]
					,S.[auditInfo.modifiedOn]
					,S.[auditInfo.requestedBy]
					,S.[auditInfo.modifiedReasonCode]
					,S.[auditInfo.channel]
					,S.[lossReason]
					,S.[distributionPurpose]
					,S.[start_end_entity_primary_contact]
					)
		WHEN MATCHED
			THEN
				UPDATE
				SET [movementId] = S.[movementId]
					,[interaction_type] = S.[interaction_type]
					,[movement_type] = S.[movement_type]
					,[movement_status] = S.[movement_status]
					,[varietyId] = S.[varietyId]
					,[propagationMethod] = S.[propagationMethod]
					,[shipmentIdentifier] = S.[shipmentIdentifier]
					,[start_end_EntityId] = S.[start_end_EntityId]
					,[start_end_GeoNodeId] = S.[start_end_GeoNodeId]
					,[sender_receiver_Id] = S.[sender_receiver_Id]
					,[sent_received_date_key] = S.[sent_received_date_key]
					,[sent_received_Qty] = S.[sent_received_Qty]
					,[price.amount] = S.[price.amount]
					,[price.currencyCode] = S.[price.currencyCode]
					,[costOfProduction.amount] = S.[costOfProduction.amount]
					,[costOfProduction.currencyCode] = S.[costOfProduction.currencyCode]
					,[auditInfo.createdBy] = S.[auditInfo.createdBy]
					,[auditInfo.createdOn] = S.[auditInfo.createdOn]
					,[auditInfo.modifiedBy] = S.[auditInfo.modifiedBy]
					,[auditInfo.modifiedOn] = S.[auditInfo.modifiedOn]
					,[auditInfo.requestedBy] = S.[auditInfo.requestedBy]
					,[auditInfo.modifiedReasonCode] = S.[auditInfo.modifiedReasonCode]
					,[auditInfo.channel] = S.[auditInfo.channel]
					,[lossReason] = S.[lossReason]
					,[distributionPurpose] = S.[distributionPurpose]
					,[start_end_entity_primary_contact] = S.[start_end_entity_primary_contact]
		WHEN NOT MATCHED BY SOURCE
			THEN
				DELETE
		OUTPUT $ACTION
			,Inserted.*
			,Deleted.*;

		SET @ROW = (
				SELECT @@ROWCOUNT
				);

		INSERT INTO [AUDIT].[data_model_merge_log] (
			schema_name
			,table_name
			,last_run_ts
			,last_run_status
			,count
			,pipeline_name
			,run_id
			)
		VALUES (
			'dm'
			,'fact_nsc_plantlet_distribution'
			,CURRENT_TIMESTAMP
			,'SUCCESS'
			,@ROW
			,@pipeline_name
			,@run_id
			);
	END TRY

	BEGIN CATCH
		EXEC @ERROR_PROC @pipeline_name = @pipeline_name
			,@run_id = @run_id;

		INSERT INTO [AUDIT].[data_model_merge_log] (
			schema_name
			,table_name
			,last_run_ts
			,last_run_status
			,count
			,pipeline_name
			,run_id
			)
		VALUES (
			'dm'
			,'fact_nsc_plantlet_distribution'
			,CURRENT_TIMESTAMP
			,'FAIL'
			,NULL
			,@pipeline_name
			,@run_id
			);
	END CATCH
END
GO

