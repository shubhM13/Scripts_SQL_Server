--receiverId - Employee
select distinct A."receiverId", B."employeeId", B."personInfo.firstName", B."personInfo.lastName", B."contactInfo.email"
from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Employee" AS B
ON A."receiverId" = B."employeeId";

--senderId - Employee
select distinct A."senderId", B."employeeId", B."personInfo.firstName", B."personInfo.lastName", B."contactInfo.email"
from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Employee" AS B
ON A."senderId" = B."employeeId";


--receiverId - Person
select distinct A."receiverId", B."personId",B."personInfo.firstName", B."personInfo.lastName", B."contactInfo.email"
from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::ET.Person" AS B
ON A."receiverId" = B."personId";

--senderId - Person
select distinct A."senderId", B."personId", B."personInfo.firstName", B."personInfo.lastName", B."contactInfo.email"
from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::ET.Person" AS B
ON A."senderId" = B."personId";

--createdBy - PersonId
select distinct A."auditInfo.createdBy", B."contactInfo.email"
from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::ET.Person" AS B
ON A."auditInfo.createdBy" = B."personId";

-- createdBy - Person.externalSystemId
select distinct A."auditInfo.createdBy", B."externalSystemId", B."contactInfo.email"
from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::ET.Person" AS B
ON A."auditInfo.createdBy" = B."externalSystemId";

-- createdBy - Person.externalSystemId2
select distinct A."auditInfo.createdBy", B."externalSystemId2", B."contactInfo.email"
from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::ET.Person" AS B
ON A."auditInfo.createdBy" = B."externalSystemId2";

--cretedBy - EmployeeId
select distinct A."auditInfo.createdBy", B."employeeId", B."contactInfo.email"
from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Employee" AS B
ON A."auditInfo.createdBy" = B."employeeId";

-- createdBy - Employee.externalSystemId
select distinct A."auditInfo.createdBy", B."externalSystemId", B."contactInfo.email"
from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Employee" AS B
ON A."auditInfo.createdBy" = B."externalSystemId";

--modifiedBy - PersonId
select distinct A."auditInfo.modifiedBy", B."personId", B."contactInfo.email"
from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::ET.Person" AS B
ON A."auditInfo.modifiedBy" = B."personId";

-- modifiedBy - Person.externalSystemId
select distinct A."auditInfo.modifiedBy", B."externalSystemId", B."contactInfo.email"
from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::ET.Person" AS B
ON A."auditInfo.modifiedBy" = B."externalSystemId";

-- modifiedBy - Person.externalSystemId2
select distinct A."auditInfo.modifiedBy", B."externalSystemId2", B."contactInfo.email"
from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::ET.Person" AS B
ON A."auditInfo.modifiedBy" = B."externalSystemId2";

--modifiedBy - EmployeeId
select distinct A."auditInfo.modifiedBy", B."employeeId", B."contactInfo.email"
from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Employee" AS B
ON A."auditInfo.modifiedBy" = B."employeeId";

-- modifiedBy - Employee.externalSystemId
select distinct A."auditInfo.modifiedBy", B."externalSystemId", B."contactInfo.email"
from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Employee" AS B
ON A."auditInfo.modifiedBy" = B."externalSystemId";

--requestedBy - PersonId
select distinct A."auditInfo.requestedBy", B."personId", B."contactInfo.email"
from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::ET.Person" AS B
ON A."auditInfo.requestedBy" = B."personId";

-- requestedBy - Person.externalSystemId
select distinct A."auditInfo.requestedBy", B."externalSystemId", B."contactInfo.email"
from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::ET.Person" AS B
ON A."auditInfo.requestedBy" = B."externalSystemId";

-- requestedBy - Person.externalSystemId2
select distinct A."auditInfo.requestedBy", B."externalSystemId2", B."contactInfo.email"
from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::ET.Person" AS B
ON A."auditInfo.requestedBy" = B."externalSystemId2";

--requestedBy - EmployeeId
select distinct A."auditInfo.requestedBy", B."employeeId", B."contactInfo.email"
from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Employee" AS B
ON A."auditInfo.requestedBy" = B."employeeId";

-- requestedBy - Employee.externalSystemId
select distinct A."auditInfo.requestedBy", B."userName", B."contactInfo.email"
from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement" AS A
--INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Employee" AS B
LEFT OUTER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Employee" AS B
ON A."auditInfo.requestedBy" = B."userName";

select distinct "auditInfo.requestedBy" from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement"; -- Null Records in the Table
select distinct "auditInfo.modifiedBy" from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement"; -- Null Records in the Table

select distinct A."auditInfo.createdBy", B."userName", B."contactInfo.email"
from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Employee" AS B
ON A."auditInfo.createdBy" = B."userName";

select distinct A."auditInfo.modifiedBy", B."userName", B."contactInfo.email"
from "FARMS"."nestle.dev.glb.farms.data.structure::PT.Movement" AS A
INNER JOIN "FARMS"."nestle.dev.glb.farms.data.structure::CT.Employee" AS B
ON A."auditInfo.requestedBy" = B."userName";



