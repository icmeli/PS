<form id="form-insert" class="form-horizontal">
	<div class="row">
		<div class="col-lg-4">
			{select label="WorkShop" name="courses_parentcode_ws" id="courses_parentcode_ws" options=$courses_parentcode_wso selected=$courses_parentcode_ws}  
			{select label="Adı" name="courses_name_ws" id="courses_name_ws" options=$courses_name_wso selected=$courses_name_ws} 
		</div>
		<div class="col-lg-4">
			{select label="Lokasyon" name="courses_locationcode" id="courses_locationcode" options=$courses_locationcodeo selected=$courses_locationcode} 
			{input type="datetime" label="Başlangıç Tarihi" id="courses_startdate" name="courses_startdate" value="{$courses_startdate}" error="{$courses_startdateerror}"}
			{input type="datetime" label="Bitiş Tarihi" id="courses_enddate" name="courses_enddate" value="{$courses_enddate}" error="{$courses_enddateerror}"}
	        {**input type="text" label="Lokasyon" name="courses_locationcode" value="{$courses_locationcode}" error="{$courses_locationcodeerror}" **}
	        {**input type="text" label="Saati" name="courses_coursetime" value="{$courses_coursetime}" error="{$courses_coursetimeerror}" **}
	    </div>
		<div class="col-lg-4">
	        {input type="text" label="Eğitmen Kodu" name="courses_instructor" value="{$courses_instructor}" error="{$courses_instructorerror}"}
	        {input label="Eğitmen Adı" type="text" id="courses_instructorName" search="module=xusrinf&context=form-insert&multi_select=0&xusrinf_full=[#courses_instructorName]&xusrinf_type=instructor&unique=coursesxusrinf"}	  
	        {**select label="Sıklığı" name="courses_frequency" id="courses_frequency" options=$courses_frequencyo selected=$courses_frequency**}
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