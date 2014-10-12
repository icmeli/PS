
<div id="content">
    <div class="wrapper clearfix">
        <form id="form-update-{$id}" data-id="{$id}" class="form-update form-horizontal">
        	<div class="row">
        		{input type="hidden" name="id" value="{$id}"}
        		<div class="col-lg-4">
        			{input type="text" label="Adı" id="xusrinf_name" name="xusrinf_name" value="{$xusrinf_name}" error="{$xusrinf_nameerror}"}
        			{input type="text" label="Soyadı" id="xusrinf_last" name="xusrinf_last" value="{$xusrinf_last}" error="{$xusrinf_lasterror}"}
        			{input type="text" label="TC Kimlik No" id="xusrinf_tcno" name="xusrinf_tcno" value="{$xusrinf_tcno}"}
        			{input type="date" label="Doğum Tarihi" id="xusrinf_birthDate" name="xusrinf_birthDate" value="{$xusrinf_birthDate}"}
        	        {input type="email" label="E-Posta" name="xusrinf_email" value="{$xusrinf_email}" error="{$xusrinf_emailerror}" icon="fa fa-envelope"}
        	        {input type="text" label="Telefon-İş" name="xusrinf_wPhone" value="{$xusrinf_wPhone}" error="{$xusrinf_wPhoneerror}" icon="fa-phone"}
        	        {input type="text" label="Telefon-Ev" name="xusrinf_hPhone" value="{$xusrinf_hPhone}" error="{$xusrinf_hPhoneerror}" icon="fa-phone"}
        	        {input type="text" label="Telefon-Cep" name="xusrinf_cPhone" value="{$xusrinf_cPhone}" error="{$xusrinf_cPhoneerror}" icon="fa-phone"}


        		</div>
        		<div class="col-lg-4">
        	        {select label="##Tip##" name="xusrinf_type" id="xusrinf_type" options=$xusrinf_typeo selected=$xusrinf_type}
        			{input type="text" label="Mesleği" id="xusrinf_job" name="xusrinf_job" value="{$xusrinf_job}"}
        			{input type="text" label="İşyeri / Okulu" id="xusrinf_jobtitle" name="xusrinf_jobtitle" value="{$xusrinf_jobtitle}"}
        	        {textarea label="Adres" name="xusrinf_address" value="{$xusrinf_address}" error="{$xusrinf_addresserror}"}
        	        {textarea label="Açıklama" name="xusrinf_description" value="{$xusrinf_description}" error="{$xusrinf_descriptionerror}"}
        	    </div>
        		<div class="col-lg-4">
        			{input type="text" label="Veli Adı" id="xusrinf_subname" name="xusrinf_subname" value="{$xusrinf_subname}"}
        			{input type="text" label="Veli Soyadı" id="xusrinf_sublastname" name="xusrinf_sublastname" value="{$xusrinf_sublastname}"}
        			{input type="text" label="Veli Mesleği" id="xusrinf_jobposition" name="xusrinf_jobposition" value="{$xusrinf_jobposition}"}
        			{input type="text" label="Boyu" id="xusrinf_floor" name="xusrinf_floor" value="{$xusrinf_floor}"}
        			{input type="text" label="Kilosu" id="xusrinf_room" name="xusrinf_room" value="{$xusrinf_room}"}
        	    </div>
        	</div>
        	<footer class="row">
        		<div class="col-lg-12">
        			<div class="btn btn-group pull-right">
        				<button type="reset" class="btn btn-info">
        					<i class="fa fa-refresh"></i> Formu Temizle
        				</button>
        				<button type="button" class="btn btn-warning delete-record" data-id="{$id}">
        					<i class="fa-trash-o"></i> Kaydı Sil
        				</button>
        				<button type="submit" class="btn btn-success form-save update">
        					<i class="fa fa-save"></i> Güncelle
        				</button>
        			</div>
        		</div>
        	</footer>
        </form>
        <div class="event_tabs" >
            {getLists userCode='' module=$smarty.get.module id=$smarty.get.id}
            <!--
            	*** güncelleme ekranlarında user_code gerekli değildir ***
            	*** güncelleme ekranının hangi modul ve id bilgisi gerekmektedir ***
            	$listCodes[]
            	$tabNames[]
            	$tabOrders[]
            	$listCaptions[listCode][]
            	$moduleName
            	$moduleCode
            	$userCode
            -->
            {assign var="tabCount" value="1"}
            <ul class="tabs">
                {foreach from=$listCodes key=k item=v}
            	<li><a href="#tabs{$tabCount++}" onclick="$('#{$v}').attr('src', 'xlistview.php?smenu={$smenu}&module={$moduleName}&moduleCode={$moduleCode}&userCode=&listCode={$v}&id={$id}&countpanel=1&hide=0&dblclick=1&recordkey=0&dblclick=1&filter=1&listcaptions=&count_id={$v}_span');">{$tabNames[$k]}<span id="{$v}_span"></span></a></li>
                {/foreach}
            </ul>
            {assign var="tabCount" value="1"}
            <div class="tab_content"> <!--  style="width:100% !important;" -->
            {foreach from=$listCodes key=k item=v}
            	<div id="tabs{$tabCount++}" style="padding:0px;">
                    <iframe src="about:blank" style="width:100%;height:400px" border="0" frameborder="0" id="{$v}" name="{$v}"></iframe>
                </div>
            {/foreach}
            </div>
        </div>
    </div>
</div>