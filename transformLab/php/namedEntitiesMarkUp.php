<?php
$dir= dirname(dirname(__FILE__));
$xsl1 = new DOMDocument();
$xsl2 = new DOMDocument();
$xsl1->load($dir."/xsl/namedEntitiesMarkUp.xsl");
$xsl2->load($dir."/xsl/date.xsl");
$files = glob($dir."/tei/*.xml");
foreach ($files as $file){
	$file_name = basename($file);
	$inputdom = new DomDocument();
	$inputdom->load($file);
	$proc = new XSLTProcessor();
	$proc->importStylesheet($xsl1);
	$newdom = $proc->transformToDoc($inputdom);
	if(strpos($file_name, "CV.xml") && file_exists(str_replace("CV.xml", "CR.xml", $file))){
		$proc->importStylesheet($xsl2);
		$proc->setParameter('', 'filename', basename($file));
		$newdom = $proc->transformToDoc($newdom);
	}
	$newdom -> save($dir."/tei/".$file_name);
}


?>