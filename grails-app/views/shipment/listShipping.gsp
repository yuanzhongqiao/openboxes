
<html>
   <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="custom" />
        <g:set var="entityName" value="${message(code: 'shipment.label', default: 'Shipping')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
		<!-- Specify content to overload like global navigation links, page titles, etc. -->
		<content tag="pageTitle">
			<g:message code="default.list.label" args="[entityName]" /></content>
    </head>    
    <body>
        <div class="body">
            <g:if test="${flash.message}">
				<div class="message">${flash.message}</div>
            </g:if>

			<h1>Shipments originating at ${session.warehouse.name}</h1>

			<g:if test="${shipments.size()==0}">
           		<div class="message">
           			<g:if test="${eventType?.name}">
           				There are no shipments with status <b>${eventType?.eventCode?.status}</b>.
           			</g:if>
           			<g:else>
   		        		There are no shipments matching your conditions.
            		</g:else>
           		</div>
           	</g:if>
            	
            <g:form action="listShipping" method="post">
           	<h3>Type:  <g:select name="shipmentType"
								from="${org.pih.warehouse.shipping.ShipmentType.list()}"
								optionKey="id" optionValue="name" value="${shipmentType}" 
								noSelection="['':'--All--']" />&nbsp;&nbsp;    
           
           	Destination:  <g:select name="destination" 
           							from="${org.pih.warehouse.core.Location.list().sort()}"
           							optionKey="id" optionValue="name" value="${destination}" 
           							noSelection="['':'--All--']" />&nbsp;&nbsp;
           								
           	Status:  <g:select name="status" 
           					   from="${org.pih.warehouse.core.EventCode.list()}"
           					   optionKey="status" optionValue="status" value="${status}" 
           					   noSelection="['':'--All--']" />&nbsp;&nbsp;	
           					   
           	from <g:jqueryDatePicker id="statusStartDate" name="statusStartDate"
												value="${statusStartDate}" format="MM/dd/yyyy"/>
			to <g:jqueryDatePicker id="statusEndDate" name="statusEndDate"
												value="${statusEndDate}" format="MM/dd/yyyy"/>
           							
			<g:submitButton name="filter" value="Filter"/>
			</h3>  
            </g:form>
            
            <br/>
            <div class="list">
				<table>
                    <thead>
                        <tr>   
                        	<th>${message(code: 'shipment.shipmentType.label', default: 'Type')}</th>
                            <th>${message(code: 'shipment.shipment.label', default: 'Shipment')}</th>							
                            <th>${message(code: 'shipment.destination.label', default: 'Destination')}
                        	<th>${message(code: 'shipment.expectedShippingDate.label', default: 'Expected Shipping Date')}</th>
                         	<th>${message(code: 'shipment.status.label', default: 'Status')}</th>
                         	<th>${message(code: 'shipment.documents.label', default: 'Documents')}</th>
                        <!--  
							<g:sortableColumn property="shipmentType" title="${message(code: 'shipment.shipmentType.label', default: 'Type')}" />
                            <g:sortableColumn property="name" title="${message(code: 'shipment.shipment.label', default: 'Shipment')}" />								
                            <g:sortableColumn property="destination" title="${message(code: 'shipment.destination.label', default: 'Destination')}" />
                        	<g:sortableColumn property="expectedShippingDate"  title="${message(code: 'shipment.expectedShippingDate.label', default: 'Expected Shipping Date')}" />
                         	<th><g:link action="listShipping">${message(code: 'shipment.status.label', default: 'Status')}</g:link></th>
                         	<th><a href="">${message(code: 'shipment.documents.label', default: 'Documents')}</a></th>
                        	-->
                        </tr>
                    </thead>
                   
                   	<tbody>
						<g:each var="shipmentInstance" in="${shipments}" status="i">
							<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">            
								<td width="3%" style="text-align: center">
									<img src="${createLinkTo(dir:'images/icons/shipmentType',file: 'ShipmentType' + shipmentInstance?.shipmentType?.name + '.png')}"
									alt="${shipmentInstance?.shipmentType?.name}" style="vertical-align: middle; width: 24px; height: 24px;" />		
								</td>										
								<td width="10%">
									<g:link action="showDetails" id="${shipmentInstance.id}">
										${fieldValue(bean: shipmentInstance, field: "name")}
									</g:link>																														
								</td>
								<td width="10%" align="center">
									${fieldValue(bean: shipmentInstance, field: "destination.name")}
								</td>
								<td width="10%" align="center">
									<g:formatDate format="dd/MMM/yyyy" date="${shipmentInstance?.expectedShippingDate}"/>
								</td>
								<td width="10%">												
									${shipmentInstance?.mostRecentEvent?.eventType?.eventCode?.status} - <g:formatDate format="dd/MMM/yyyy" date="${shipmentInstance?.mostRecentEvent?.eventDate}"/>									
								</td>
								<td width="15%">
									<g:if test="${!shipmentInstance.documents}"><span class="fade">(empty)</span></g:if>
									<g:else>
										<g:each in="${shipmentInstance.documents}" var="document" status="j">
											<div id="document-${document.id}">
												<img src="${createLinkTo(dir:'images/icons/',file:'document.png')}" alt="Document" style="vertical-align: middle"/>
												<g:link controller="document" action="download" id="${document.id}">${document?.documentType?.name} (${document?.filename})</g:link>
											</div>
										</g:each>							
									</g:else>
								</td>
	                        </tr>
						</g:each>                    		
                    </tbody>
				</table>
            </div>
        </div>		
    </body>
</html>
