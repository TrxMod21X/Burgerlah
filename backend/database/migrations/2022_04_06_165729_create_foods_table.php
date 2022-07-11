<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateFoodsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('foods', function (Blueprint $table) {
            $table->increments('id')->unsigned();
            $table->string('name');
            $table->text('description');
            $table->integer('price');
            $table->integer('stars');
            $table->integer('people');
            $table->integer('selected_people');
            $table->string('img');
            $table->string('location');
            $table->timestamps();
            $table->tinyInteger('type_id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('foods');
    }
}
