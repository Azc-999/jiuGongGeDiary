package dairy.DBTool;

import java.util.ArrayList;
import java.util.List;

import dairy.model.Diary;


public class PagingTool {
	public List<Diary> list=null;
	private int Count=0;	//记录数
	private int pagesize=0;		//每页显示的记录数
	private int maxPage=0;		//最大页数
	public List<Diary> getInitPage(List<Diary> list,int Page,int pagesize){
		List<Diary> newList=new ArrayList<Diary>();
		this.list=list;
		Count=list.size();	//获取list集合的元素个数
		this.pagesize=pagesize;
		this.maxPage=getMaxPage();	//获取最大页数
		try{
		for(int i=(Page-1)*pagesize;i<=Page*pagesize-1;i++){
			try{
				if(i>=Count){break;}
			}catch(Exception e){}
				newList.add((Diary)list.get(i));
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		return newList;
	}
	public List<Diary> getAppointPage(int Page){
		List<Diary> newList=new ArrayList<Diary>();
		try{
			for(int i=(Page-1)*pagesize;i<=Page*pagesize-1;i++){
				try{
					if(i>=Count){break;}
				}catch(Exception e){}
					newList.add((Diary)list.get(i));
			}
			}catch(Exception e){
				e.printStackTrace();
			}
			return newList;
	}
	public int getMaxPage(){
		int maxPage=(Count%pagesize==0)?(Count/pagesize):(Count/pagesize+1);
		return maxPage;
	}
	public int getRecordSize(){
		return Count;
	}
	public int getPage(String str){
		if(str==null){//当页数等于null时，让其等于0
			str="0";
		}
		int Page=Integer.parseInt(str);
		if(Page<1){//当页数小于1时，让其等于1
			Page=1;
		}else{
			if(((Page-1)*pagesize+1)>Count){//当页数大于最大页数时，让其等于最大页数
				Page=maxPage;
			}
		}
		return Page;
	}
	public String printCtrl(int Page,String url,String para){
		String strHtml="<table width='100%'  border='0' cellspacing='0' cellpadding='0'>"
				+ "<tr> <td height='24' align='right'>当前页数：【"+Page+"/"+maxPage+"】&nbsp;";
		try{
		if(Page>1){
			strHtml=strHtml+"<a href='"+url+"&Page=1"+para+"'>第一页</a>　";
			strHtml=strHtml+"<a href='"+url+"&Page="+(Page-1)+para+"'>上一页</a>";
		}
		if(Page<maxPage){
			strHtml=strHtml+"<a href='"+url+"&Page="+(Page+1)+para+"'>下一页</a>"
					+ "　<a href='"+url+"&Page="+maxPage+para+"'>最后一页&nbsp;</a>";
		}
		strHtml=strHtml+"</td> </tr>	</table>";
		}catch(Exception e){
			e.printStackTrace();
		}
		return strHtml;
	}
}
