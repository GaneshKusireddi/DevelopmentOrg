<aura:application >
 <!-- Create attribute to store lookup value as a sObject--> 
  <aura:attribute name="selectedLookUpRecord" type="sObject" default="{}"/>
  <c:RT_User_Team objectAPIName="User" IconName="standard:User" selectedRecord="{!v.selectedLookUpRecord}" label="UserName"/>
</aura:application>