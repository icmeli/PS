{include file="document_header.tpl"}
<section id="container" class="">
	<!--header start-->
	<header class="header white-bg">
		<div class="sidebar-toggle-box">
			<div data-original-title="Menüyü Göster / Gizle" data-placement="right" class="fa fa-bars tooltips menu-toggle"></div>
		</div>
		<!--logo start-->
		<a href="{$www}!{$get_string}" class="logo">
			<b class="hide-768">Platform</b><span>Sanat</span>
		</a>
		<!--logo end-->
		<div class="nav notify-row" id="top_menu">
			{if $smarty.get.h}
				{include file="headerrow_{$smarty.get.h}.tpl"}
			{else}
				{include file="headerrow_default.tpl"}
			{/if}
		</div>
		<div class="top-nav ">
			<ul class="nav pull-right top-menu">
				<li clss="top-search-bar" style="display:none;">
					<input type="text" class="form-control search" placeholder="Ara">
				</li>
				<!-- user login dropdown start-->
				{if $smarty.get.themeswitcher == "1"}
					{include file="themeswitcher.tpl"}
				{/if}
				{include file="usermenu.tpl"}
				<!-- user login dropdown end -->
			</ul>
		</div>
	</header>
	<!--header end-->
	<!--sidebar start-->
	<aside>
		<div id="sidebar" class="nav-collapse ">
			<!-- sidebar menu start-->
			{getUserMenu id="nav-accordion" class="windesk-menu sidebar-menu" container="sub-menu" subcontainer="sub"}
			<!-- sidebar menu end-->
		</div>
	</aside>
	<!--sidebar end-->
	<!--main content start-->
	<section id="main-content">
		<section class="wrapper">
			<!-- page start-->
