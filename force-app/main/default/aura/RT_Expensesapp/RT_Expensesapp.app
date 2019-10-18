<aura:application extends="force:slds">
     <!-- Create attribute to store lookup value as a sObject--> 
  <aura:attribute name="selectedLookUpRecord" type="sObject" default="{}"/>
  <c:RT_Expenses objectAPIName="account" IconName="standard:account" selectedRecord="{!v.selectedLookUpRecord}" label="Client"/>

  <!--  <c:RT_Expenses />  -->
</aura:application>