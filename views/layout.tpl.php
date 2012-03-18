<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8" />
	<title><?php $this->title and print $this->eprint($this->title) . " | "; ?>Shukumei Beta</title>
	<link rel="stylesheet" href="<?php echo BETA_ROOT_URL; ?>/style/style.css" />
</head>
<body>
	<div id="main">
		<div id="header">
			<h1><a href="<?php echo BETA_ROOT_URL; ?>">Shukumei</a></h1>
			<div id="circle"></div>
			<div id="search">
				<input type="text" placeholder="search" name="q" /> <input type="image" src="<?php echo BETA_ROOT_URL; ?>/style/images/go.png" value="go" />
			</div>
			<div id="quick-menu" class="menu">
				<ul>
					<li><a href="#" class="bank">Bank</a></li>
					<li><a href="#" class="inventory">Inventory</a></li>
					<li><a href="#" class="chars">Characters</a></li>
					<li><a href="#" class="messages">Messages</a></li>
				</ul>
			</div>
		</div><!-- #header -->
		<div id="navigation" class="menu">
			<ul>
				<li><a href="<?php echo BETA_ROOT_URL; ?>/news/">News</a></li>
				<li><a href="<?php echo BETA_ROOT_URL; ?>/games/">Games</a></li>
				<li><a href="<?php echo BETA_ROOT_URL; ?>/forum/">Forum</a></li>
				<li><a href="<?php echo BETA_ROOT_URL; ?>/account/">Account</a></li>
			</ul>
		</div><!-- #navigation -->
		<div id="body">
			<div id="user-menu" class="menu">
				<ul>
					<li>Heya, <strong>Guest</strong></li>
					<li>14,000 g</li>
					<li><?php echo date("F jS, Y"); ?></li>
					<li><?php echo date("g:i a"); ?></li>
				</ul>
			</div>
			<div id="content">
        <?php echo $this->content; ?>
			</div> <!-- #content -->
      <div id="footer">
        Copyright &copy; <?php echo date('Y'); ?> Shukumei Beta.  All rights reserved.
      </div>
		</div> <!-- #body -->
	</div> <!-- #main -->
</body>
</html>
