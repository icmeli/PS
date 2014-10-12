<form id="form-search-fields" class="form-horizontal {$module}" data-module="{$module}">
	<div class="row">
		<div class="col-lg-4">
			{input type="text" label="Adı" id="xusrinf_name" name="xusrinf_name" value="{$xusrinf_name}" error="{$xusrinf_nameerror}" action="filter-btn fa-plus"}
			{input type="text" label="Soyadı" id="xusrinf_last" name="xusrinf_last" value="{$xusrinf_last}" error="{$xusrinf_lasterror}" action="filter-btn fa-plus"}
			{input type="text" label="TC Kimlik No" id="xusrinf_tcno" name="xusrinf_tcno" value="{$xusrinf_tcno}" action="filter-btn fa-plus"}
			{input type="date" label="Doğum Tarihi" id="xusrinf_birthDate" name="xusrinf_birthDate" value="{$xusrinf_birthDate}" action="filter-btn fa-plus"}
	        {input type="email" label="E-Posta" name="xusrinf_email" value="{$xusrinf_email}" error="{$xusrinf_emailerror}" icon="fa fa-envelope" action="filter-btn fa-plus"}
	        {input type="text" label="Telefon-Cep" name="xusrinf_cPhone" value="{$xusrinf_cPhone}" error="{$xusrinf_cPhoneerror}" icon="fa-phone" action="filter-btn fa-plus"}
	        {input type="text" label="Telefon-Ev" name="xusrinf_hPhone" value="{$xusrinf_hPhone}" error="{$xusrinf_hPhoneerror}" icon="fa-phone" action="filter-btn fa-plus"}
	        {input type="text" label="Telefon-İş" name="xusrinf_wPhone" value="{$xusrinf_wPhone}" error="{$xusrinf_wPhoneerror}" icon="fa-phone" action="filter-btn fa-plus"}
			{input type="text" label="Mesleği" id="xusrinf_job" name="xusrinf_job" value="{$xusrinf_job}" action="filter-btn fa-plus"}
			{input type="text" label="İşyeri / Okulu" id="xusrinf_jobtitle" name="xusrinf_jobtitle" value="{$xusrinf_jobtitle}" action="filter-btn fa-plus"}
		</div>
		<div class="col-lg-4">
	        {select label="##Tip##" name="xusrinf_type" id="xusrinf_type" options=$xusrinf_typeo selected=$xusrinf_type action="filter-btn fa-plus"}
			{input type="text" label="Boyu" id="xusrinf_floor" name="xusrinf_floor" value="{$xusrinf_floor}" action="filter-btn fa-plus"}
			{input type="text" label="Kilosu" id="xusrinf_room" name="xusrinf_room" value="{$xusrinf_room}" action="filter-btn fa-plus"}
	        {input type="textarea" label="Adres" name="xusrinf_address" value="{$xusrinf_address}" error="{$xusrinf_addresserror}" action="filter-btn fa-plus"}
	        {input type="text" label="Açıklama" name="xusrinf_description" value="{$xusrinf_description}" error="{$xusrinf_descriptionerror}" action="filter-btn fa-plus"}
			{input type="text" label="Veli Adı" id="xusrinf_subname" name="xusrinf_subname" value="{$xusrinf_subname}" action="filter-btn fa-plus"}
			{input type="text" label="Veli Soyadı" id="xusrinf_sublastname" name="xusrinf_sublastname" value="{$xusrinf_sublastname}" action="filter-btn fa-plus"}
			{input type="text" label="Veli Mesleği" id="xusrinf_jobposition" name="xusrinf_jobposition" value="{$xusrinf_jobposition}" action="filter-btn fa-plus"}
		</div>
		<div class="col-lg-4">
			{include file="xlistview_filter.tpl"}
		</div>
	</div>
	<footer class="row">
		<div class="col-lg-12">
			<div class="btn pull-right">
				<button class="btn btn-info" type="reset">
					<i class="fa fa-refresh"></i> Formu Temizle
				</button>
				<button class="btn btn-danger form-search-submit" type="button">
					<i class="fa fa-search"></i> Ara
				</button>
			</div>
		</div>
	</footer>
</form>
