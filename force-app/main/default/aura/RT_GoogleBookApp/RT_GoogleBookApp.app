<aura:application extends="force:slds">
    <lightning:card iconName="custom:custom55" >
        <aura:set attribute="title">
            <div class="boldFont" >
                Google Book Search 
            </div>
        </aura:set>
        
        <lightning:layout >
            <div class="slds-col slds-size_2-of-3 lightingBlue">
                <!-- BookSearchform  -->
                <c:RT_GoogleBookDetails/>
            </div>
            <div class="slds-col slds-size_1-of-3">
                <!-- Book details-->
                <c:RT_GoogleBook_BookDetails/>  
            </div>  
        </lightning:layout>
    </lightning:card>
</aura:application>