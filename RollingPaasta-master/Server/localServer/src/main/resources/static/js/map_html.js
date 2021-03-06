function draw(){
	var canvas = document.getElementById("canvas");
	if(canvas.getContext){
		var ctx = canvas.getContext("2d"); 
					
		ctx.strokeStyle = "#36AF12";
		ctx.lineWidth = 4;
		// if문 써서 1이면 #D4171E, 2면 #F8CF3F
					
					
		// Draw a Line
		//1구역
		ctx.font = "10px Arial";
		ctx.fillText("수원광명고속도로", 10, 30);
		ctx.moveTo(50,0);
		ctx.lineTo(85,75);
		// ctx.lineWidth = 15;
		//2구역
		ctx.moveTo(120,0);
		ctx.lineTo(35,120);
		//3구역
		ctx.moveTo(85, 75);
		ctx.lineTo(120, 130);
		//4구역
		ctx.font = "10px Arial";
		ctx.fillText("일반국도43호선", 10, 210);
		ctx.moveTo(35,120);
		ctx.lineTo(30,275);
		//5구역
		ctx.moveTo(120, 130);
		ctx.lineTo(110, 220);
		ctx.moveTo(110, 220);
		ctx.lineTo(150, 300);
		//6구역
		ctx.moveTo(30,275);
		ctx.lineTo(95,240);
		//7구역
		ctx.moveTo(95,240);
		ctx.lineTo(350,230);
		//8구역
		ctx.moveTo(30,275);
		ctx.lineTo(25,370);
		//9구역
		ctx.font = "10px Arial";
		ctx.fillText("수도권제2순환고속도로", 90, 285);
		ctx.moveTo(150, 300);
		ctx.lineTo(300, 340);
		ctx.moveTo(300, 340);
		ctx.lineTo(350, 380);
		//10구역
		ctx.font = "10px Arial";
		ctx.fillText("오산화성고속도로", 375, 300);
		ctx.moveTo(440, 240);
		ctx.lineTo(420, 300);
		ctx.moveTo(420, 300);
		ctx.lineTo(360, 360);
		ctx.stroke();
					
					
		// 수원대학교
		ctx.beginPath();
		ctx.arc(200, 150, 40, 0, 2 * Math.PI);
		ctx.stroke();
		ctx.font = "15px Arial";
		ctx.fillText("University of Suwon", 200, 160);
                    
		}
}