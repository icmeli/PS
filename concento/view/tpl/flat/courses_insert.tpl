<form id="form-insert" class="form-horizontal">
	<div class="row">
		<div class="col-lg-4">
			{select label="Adı" name="courses_name" id="courses_name" options=$courses_nameo selected=$courses_name} 
			{input type="datetime" label="Başlangıç Tarihi" id="courses_startdate" name="courses_startdate" value="{$courses_startdate}" error="{$courses_startdateerror}" onchange="setEndDate();"}
			{input type="datetime" label="Bitiş Tarihi" id="courses_enddate" name="courses_enddate" value="{$courses_enddate}" error="{$courses_enddateerror}"}
		</div>
		<div class="col-lg-4">
			{select label="Lokasyon" name="courses_locationcode" id="courses_locationcode" options=$courses_locationcodeo selected=$courses_locationcode} 
	        {input type="text" label="Kota" name="courses_quota" value="{$courses_quota}" error="{$courses_quotaerror}" }
	    </div>
		<div class="col-lg-4">
	        {input type="text" label="Eğitmen Kodu" name="courses_instructor" value="{$courses_instructor}" error="{$courses_instructorerror}"}
	        {input label="Eğitmen Adı" type="text" id="courses_instructorName" search="module=xusrinf&context=form-insert&multi_select=0&xusrinf_full=[#courses_instructorName]&xusrinf_type=instructor&unique=coursesxusrinf"}	  
	        {input type="text" label="Parent Code" name="courses_parentcode" value="routine" error="{$courses_parentcodeerror}" }  
	    </div>
	</div>
	<footer class="row">
		<div class="col-lg-12">
			<div class="btn pull-right">
				<button type="reset" class="btn btn-info">
					<i class="fa fa-refresh"></i> Formu Temizle
				</button>
				<div class="btn-group">
					<button type="submit" class="btn btn-success form-save">
						<i class="fa fa-save"></i> Kaydet
					</button>
				</div>
			</div>
		</div>
	</footer>
</form>

<script>
function setEndDate(){
	var std = $('#form-insert #courses_startdate').val().split(" ");
	var str = std[1];
	var res = str.split(":"); 
	$('#form-insert #courses_enddate').val( std[0]+" "+( parseInt(res[0]) + 1)+":"+res[1]+":00" );
	var start = std[0]+' '+res[0]+':'+res[1]+':00';
	setTimeout("$('#form-insert #courses_startdate').val('"+start+"');",750);
}
</script>