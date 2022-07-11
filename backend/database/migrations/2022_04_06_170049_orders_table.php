<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class OrdersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->increments('id');
            $table->bigInteger('user_id');
            $table->decimal('order_amount');
            $table->string('payment_status', 191)->nullable()->default('pending');
            $table->string('order_status', 191)->default('pending');
            $table->timestamp('confirmed')->nullable();
            $table->timestamp('accepted')->nullable();
            $table->tinyInteger('scheduled')->default(0);
            $table->timestamp('processing')->nullable();
            $table->timestamp('handover')->nullable();
            $table->timestamp('failed')->nullable();
            $table->timestamp('scheduled_at')->nullable();
            $table->bigInteger('delivery_address_id')->nullable();
            $table->text('order_note');
            $table->timestamps();
            $table->decimal('delivery_charge',6,2)->nullable();
            $table->text('delivery_address');
            $table->string('otp', 191);
            $table->timestamp('pending')->nullable();
            $table->timestamp('picked_up')->nullable();
            $table->timestamp('delivered')->nullable();
            $table->timestamp('canceled')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('orders');
    }
}
