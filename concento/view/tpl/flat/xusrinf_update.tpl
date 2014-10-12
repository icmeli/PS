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

{include file="xlistview_tabs.tpl"}