<?php

$ead = new DOMDocument();
$ead->load("ead.xml");
$ead = new DOMXpath($ead);
$daos = $ead->evaluate("//dao[@href]");

//pour chaque fichier
$files = glob("Current/*.xml");
// $refs=array();
// $meetings=array();
// $facs=array();
$i=0;
foreach($files as $file){
	// $dom = new DOMDocument();
	// $dom->load($file);
	// $xp = new DOMXpath($dom);
	// $xp->registerNamespace("tei", "http://www.tei-c.org/ns/1.0");
	$filename["text"] = basename($file, ".xml");
	$filename["scan"] = substr($filename["text"], 1, 8);
	$filename["type"] = substr($filename["text"], strrpos($filename["text"], "-")+1, 2);
	$filename["date"] = substr($filename["text"], 10, -3);
	switch($filename["type"]){
		case "CV":
			$needle = "convocation";
			break;
		case "CR":
			$needle = "compterendu";
			break;
		case "OJ":
			$needle = "ordredujour";
			break;
	}
	// echo "\n\n\t".$filename["text"]."\n";
	// echo $needle."\n";
	$match = false;
	foreach($daos as $dao){
		$href = $dao->getAttribute("href");
		$scan = substr($href, 38, 8);
		if($scan == $filename["scan"]){
			//on est dans le bon dossier
			$items = $ead->evaluate("./following-sibling::scopecontent//item[not(@corresp)]",$dao);
			foreach($items as $item){
				$ead_title = $item->textContent;
				$ead_title = str_replace(array(" ","-"), "", strtolower($ead_title));
				// echo $ead_title."\n";
				if(strpos($ead_title, $needle)!==false){
					// echo "match"."\n";
					$i++;
					$match = true;
					break;
				}
			}
			break;
		}
	}
	if(!$match){
		echo $filename["type"]."\n";
	}
}
echo $i;

?>
