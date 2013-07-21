<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8" />
	<title><?php $this->title and print $this->eprint($this->title) . " | "; ?>Shukumei Beta</title>
	<link rel="stylesheet" href="<?php Beta::static_file('style/style.css'); ?>" />
  <?php if (property_exists($this, 'stylesheets')): foreach ($this->stylesheets as $stylesheet): ?>
    <link rel="stylesheet" href="<?php Beta::static_file("style/$stylesheet"); ?>" />
  <?php endforeach; endif; ?>
</head>
<body>
	<div id="main">
		<div id="header">
			<h1><a href="<?php echo BETA_ROOT_URL; ?>">Shukumei</a></h1>
			<div id="circle"></div>
			<div id="search">
        <form action="<?php echo BETA_ROOT_URL; ?>/search/" method="post">
					<input type="text" placeholder="search" name="q" /> <input type="image" src="<?php Beta::static_file('style/images/go.png'); ?>" value="go" />
        </form>
			</div>
			<div id="quick-menu" class="menu">
				<ul>
					<li><a href="<?php echo BETA_ROOT_URL; ?>/bank/" class="bank">Bank</a></li>
					<li><a href="<?php echo BETA_ROOT_URL; ?>/inventory/" class="inventory">Inventory</a></li>
					<li><a href="<?php echo BETA_ROOT_URL; ?>/characters/" class="chars">Characters</a></li>
					<li><a href="<?php echo BETA_ROOT_URL; ?>/messages/" class="messages">Messages</a></li>
				</ul>
			</div>
		</div><!-- #header -->
		<div id="navigation" class="menu">
			<ul>
        <!--
				<li><a href="<?php echo BETA_ROOT_URL; ?>/news/">News</a></li>
				<li><a href="<?php echo BETA_ROOT_URL; ?>/games/">Games</a></li>
        -->
				<li><a href="<?php echo BETA_ROOT_URL; ?>/forum/">Forum</a></li>
				<li><a href="<?php echo BETA_ROOT_URL; ?>/user/<?php echo Beta::username(); ?>/">Account</a></li>
				<li><a href="<?php echo BETA_ROOT_URL; ?>/user/">Users</a></li>
			</ul>
		</div><!-- #navigation -->
		<div id="body">
			<div id="user-menu" class="menu">
				<ul>
					<li>Heya, <strong><a href="<?php echo BETA_ROOT_URL; ?>/user/<?php $this->eprint(Beta::username()); ?>"><?php $this->eprint(Beta::username()); ?></a></strong></li>
					<li><?php echo number_format(Beta::user_info()->gold); ?> g</li>
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
