IF NOT EXISTS (
		SELECT 1
		FROM INFORMATION_SCHEMA.ROUTINES
		WHERE ROUTINE_SCHEMA = 'dm'
			AND ROUTINE_NAME = 'uspSelectEntityMaster'
		)
BEGIN
	EXEC ('CREATE PROCEDURE dm.uspSelectEntityMaster AS SELECT 1')
END
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 10th Feb, 2021
 PURPOSE    : EntityMaster Model
 *******************************************/
GO

ALTER PROCEDURE dm.uspSelectEntityMaster
AS
BEGIN TRY
	BEGIN TRANSACTION

	SET NOCOUNT ON

	SELECT DISTINCT A.entityId
		,isnull(A.externalSystemId, '') AS externalSystemId
		,isnull(A.entityType, '') AS entityType
		,isnull(F.label, '') AS entityTypeTxt
		,isnull(A.STATUS, '') AS entityStatus
		,isnull(E.label, '') AS entityStatusTxt
		,isnull(A.name, '') AS entityName
		,isnull(A.[coordinates.longX], 0) AS longX
		,isnull(A.[coordinates.latY], 0) AS latY
		,isnull(CAST(A.altZ AS FLOAT(53)), 0) AS altZ
		,isnull(CAST(A.nestleOwned AS BIT), 0) AS nestleOwned
		,isnull(A.ownershipType, '') AS ownershipType
		,isnull(G.label, '') AS ownershipTypeTxt
		,CAST(A.foundationYear AS DATETIME)
		,CAST(A.AAAEntryYear AS DATETIME)
		,CAST(A.relationshipDate AS DATETIME)
		,isnull(CAST(A.nurseryOnSite AS TINYINT), 0) AS nurseryOnSite
		,isnull(A.millOnSite, 0) AS millOnSite
		,isnull(CAST(A.isPartOfAgripreneurship AS BIT), 0) AS isPartOfAgripreneurship
		,CASE 
			WHEN A.locationVerified = 0
				OR A.locationVerified IS NULL
				THEN 'No'
			ELSE 'Yes'
			END AS locationVerified
		,CASE 
			WHEN A.[coordinates.longX] IS NOT NULL
				AND A.[coordinates.latY] IS NOT NULL
				AND A.[coordinates.longX] >= - 180
				AND A.[coordinates.longX] <= 180
				AND A.[coordinates.latY] >= - 90
				AND A.[coordinates.latY] <= 90
				THEN 'Yes'
			ELSE 'No'
			END AS isValidCoordinates
		,isnull(B.status4C, '') AS status4C
		,isnull(H.label, '') AS status4CTxt
		,isnull(B.license4C, '') AS license4C
		,isnull(C.externalSystemId, '') AS unit4C
		,isnull(L.groupId, '') AS groupId
		,isnull(L.externalSystemId, '') AS extGroupId
		,isnull(L.name, '') AS groupName
		,isnull(L.STATUS, '') AS groupStatus
		,isnull(K.organisationId, '') AS orgId
		,isnull(K.externalSystemId, '') AS extOrgId
		,isnull(K.name, '') AS orgName
		,isnull(K.lineOfBusiness, '') AS orgLOB
		,isnull(D.sub_cluster_name, '') AS subcluster_name
		,isnull(D.cluster_name, '') AS cluster_name
		,isnull(D.country_name, '') AS country_name
	FROM dwh.ET_Entity AS A WITH (NOLOCK)
	LEFT OUTER JOIN dwh.MT_FarmSummary AS B WITH (NOLOCK) ON A.entityId = B.entityId
		AND A.STATUS != 'DELETED'
	LEFT OUTER JOIN dwh.ET_Group AS C WITH (NOLOCK) ON B.latest4CGroupId = C.groupId
		AND C.type = 'CERTIFICATION'
		AND C.certificationType = '4C'
	LEFT OUTER JOIN dm.dim_geonode_flat AS D WITH (NOLOCK) ON A.geoNodeId = D.geoNodeId
	LEFT OUTER JOIN dwh.CT_ListOption_Txt AS E WITH (NOLOCK) ON A.STATUS = E.itemCode
		AND E.setId = 'ENTITY_STATUS'
		AND E.LANGUAGE = 'E'
	LEFT OUTER JOIN dwh.CT_ListOption_Txt AS F WITH (NOLOCK) ON A.entityType = F.itemCode
		AND F.setId = 'ENTITY_TYPE'
		AND F.LANGUAGE = 'E'
	LEFT OUTER JOIN dwh.CT_ListOption_Txt AS G WITH (NOLOCK) ON A.ownershipType = G.itemCode
		AND G.setId = 'OWNERSHIP_TYPE'
		AND G.LANGUAGE = 'E'
	LEFT OUTER JOIN dwh.CT_ListOption_Txt AS H WITH (NOLOCK) ON B.status4C = H.itemCode
		AND H.setId = '4C_STATUS'
		AND H.LANGUAGE = 'E'
	LEFT OUTER JOIN [dwh].[ET_GroupToEntity] AS I WITH (NOLOCK) ON A.entityId = I.entityId
	LEFT OUTER JOIN [dwh].[ET_GroupToOrg] AS J WITH (NOLOCK) ON I.groupId = J.groupId
	LEFT OUTER JOIN [dwh].[CT_Organisation] AS K WITH (NOLOCK) ON J.organisationId = K.organisationId
	LEFT OUTER JOIN [dwh].[ET_Group] AS L WITH (NOLOCK) ON I.groupId = L.groupId

	SET NOCOUNT OFF

	COMMIT TRANSACTION
END TRY

BEGIN CATCH
	INSERT INTO dbo.DB_Errors
	VALUES (
		SUSER_SNAME()
		,ERROR_NUMBER()
		,ERROR_STATE()
		,ERROR_SEVERITY()
		,ERROR_LINE()
		,ERROR_PROCEDURE()
		,ERROR_MESSAGE()
		,GETDATE()
		);

	-- Transaction uncommittable
	IF (XACT_STATE()) = - 1
		ROLLBACK TRANSACTION

	-- Transaction committable
	IF (XACT_STATE()) = 1
		COMMIT TRANSACTION
END CATCH
GO

