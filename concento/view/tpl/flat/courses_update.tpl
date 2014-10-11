{getCourseStudents id=$id}
<form id="form-update-{$id}" data-id="{$id}" class="form-update form-horizontal">
	<div class="row">
		{input type="hidden" name="id" value="{$id}"}
		<div class="col-lg-4">
			{select label="Adı" name="courses_name" id="courses_name" options=$courses_nameo selected=$courses_name}
			{input type="text" label="Başlangıç Tarihi" id="courses_startdate" name="courses_startdate" value="{$courses_startdate}" error="{$courses_startdateerror}"}
			{input type="text" label="Bitiş Tarihi" id="courses_enddate" name="courses_enddate" value="{$courses_enddate}" error="{$courses_enddateerror}"}
			{select label="Öğrenciler" name="courses_students" id="courses_students" options=$courses_studentso selected=$students multiple="multiple"}
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
<script>
$('#form-update-{$id} #courses_students').multiSelect({
    selectableHeader: "<input type='text' class='form-control search-input' autocomplete='off' placeholder='search...'>",
    selectionHeader: "<input type='text' class='form-control search-input' autocomplete='off' placeholder='search...'>",
    afterInit: function (ms) {
        var that = this,
            $selectableSearch = that.$selectableUl.prev(),
            $selectionSearch = that.$selectionUl.prev(),
            selectableSearchString = '#' + that.$container.attr('id') + ' .ms-elem-selectable:not(.ms-selected)',
            selectionSearchString = '#' + that.$container.attr('id') + ' .ms-elem-selection.ms-selected';

        that.qs1 = $selectableSearch.quicksearch(selectableSearchString)
            .on('keydown', function (e) {
                if (e.which === 40) {
                    that.$selectableUl.focus();
                    return false;
                }
            });

        that.qs2 = $selectionSearch.quicksearch(selectionSearchString)
            .on('keydown', function (e) {
                if (e.which == 40) {
                    that.$selectionUl.focus();
                    return false;
                }
            });
    },
    afterSelect: function () {
        this.qs1.cache();
        this.qs2.cache();
    },
    afterDeselect: function () {
        this.qs1.cache();
        this.qs2.cache();
    }
});

</script>