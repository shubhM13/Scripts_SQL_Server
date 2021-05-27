CREATE TABLE DS.ET.EntityGeoSpatial (
	"entityId_geo" VARCHAR(50) NOT NULL
	,"entityGeoLocation" ST_GEOMETRY(1000004326) CS_GEOMETRY
	,PRIMARY KEY ("entityId_geo")
	);