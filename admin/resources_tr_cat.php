<?
require_once '../admin.common.prepend.php';

if (isset($_POST['rows']) && $_POST['rows'] != '') {
    $i = $_POST['rows'];
}
?>
<tr>
    <td width="21.5%" class=""><label for="">Category:</label></td>
    <td width="" >
        <input style="width:95%;" id="<?= $i ?>" class="cat_autocomplete" autocomplete="off" required type='text' name="" value="<?= $cat_info['full_name'] ?>" placeholder="Search for category..." title="Category Search"/>
    </td>
    <td  width="20%" >
        <input style="width:100%; background-color: lightgrey" id="id_<?= $i ?>" type='text' readonly name="res_cats[]" value="<?= $res_cat ?>" title="Category ID"/>
    </td>
</tr>
