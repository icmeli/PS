{include file="breadcrumb.tpl"}
<div class="row">
	<div class="col-lg-12">
		<section id="tab-container" class="panel tab-panel">
			<header class="tab-header panel-heading tab-bg-dark-navy-blue navbar-big">
				<ul id="tab-tabs" class="nav navbar-nav">
					<li class="wht-color navbar-brand navbar-icon">
						<i class="menu-auto-page-icon"></i>
					</li>
					<li class="active">
						<a href="#section-list" data-toggle="tab"><i class="fa fa-list"></i> Listele</a>
					</li>
					<li>
						<a href="#section-add" data-toggle="tab"><i class="fa fa-plus"></i> Ekle</a>
					</li>
				</ul>
			</header>
			<div class="panel-body tab-body">
				<div class="tab-content">
					<div class="tab-pane active search-fields" id="section-list">
						{include file="{$module}_searchfields.tpl"}
					</div>
					<div class="tab-pane" id="section-add">
						{include file="{$module}_insert.tpl"}
					</div>
				</div>
			</div>
		</section>
		<section id="section-listview" class="panel" style="overflow:hidden;">
			{getUrl module="{$module}" count="{$smarty.get.count|default:"30"}" from="{$smarty.get.from|default:"0"}"}
		</section>
	</div>
</div>

