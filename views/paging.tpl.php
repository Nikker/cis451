<div class="paging">
  <?php if ($this->page > 1): ?>
    <div class="previous">
      <a href="?<?php 
        echo http_build_query(
          array_merge(
            $_GET, 
            array('page' => $this->page - 1)
          )
        ); ?>">Previous page</a>
    </div>
  <?php endif; ?>
  <?php if ($this->page < $this->pages): ?>
    <div class="next">
      <a href="?<?php 
        echo http_build_query(
          array_merge(
            $_GET, 
            array('page' => $this->page + 1)
          )
        ); ?>">Next page</a>
    </div>
  <?php endif; ?>
</div>
