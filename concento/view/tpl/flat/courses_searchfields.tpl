<form id="form-search-fields" class="form-horizontal {$module}" data-module="{$module}">
	<div class="row">
		<div class="col-lg-4">
			{select label="Adı" name="courses_name" id="courses_name" options=$courses_nameo selected=$courses_name  action="filter-btn fa-plus"} 
			{input type="datetime" label="Başlangıç Tarihi" id="courses_startdate" name="courses_startdate" value="{$courses_startdate}" error="{$courses_startdateerror}" action="filter-btn fa-plus"}
			{input type="datetime" label="Bitiş Tarihi" id="courses_enddate" name="courses_enddate" value="{$courses_enddate}" error="{$courses_enddateerror}" action="filter-btn fa-plus"} 
	        {input type="text" label="Kota" name="courses_quota" value="{$courses_quota}" error="{$courses_quotaerror}" } 
	        {input type="text" label="Parent Code" name="courses_parentcode" value="routine" error="{$courses_parentcodeerror}" } 
		</div>
		<div class="col-lg-4">
	        {input type="text" label="Lokasyon" name="courses_locationcode" value="{$courses_locationcode}" error="{$courses_locationcodeerror}" action="filter-btn fa-plus"}
	        {input type="text" label="Eğitmen Kodu" name="courses_instructor" value="{$courses_instructor}" error="{$courses_instructorerror}" action="filter-btn fa-plus"}	        
	        {input label="Eğitmen Adı" type="text" id="courses_instructorName" search="module=xusrinf&context=form-insert&multi_select=0&xusrinf_full=[#courses_instructorName]&xusrinf_type=instructor&unique=coursesxusrinf"}				  
	        {select label="Sıklığı" name="courses_frequency" id="courses_frequency" options=$courses_frequencyo selected=$courses_frequency action="filter-btn fa fa-plus"}
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
